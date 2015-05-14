---
title: "The challenge of asset packaging on Heroku"
date: "2011-02-15 21:04 PST"
tags: "heroku, performance, ruby on rails"
---
Page load time is an important consideration in web application development. Users have an expectation that navigating a website should be fast, and many people will simply leave if it takes too long to load a page. Two ways to improve it are to minimize the number of HTTP requests and to minimize the amount of data transferred. Both of these can be improved by concatenating, minifying, and caching CSS and JavaScript files.

Rails has a handy feature that helps with part of this: the `stylesheet_link_tag` and `javascript_include_tag` helper methods accept a `cache` option, which will take all files passed to them and concatenate them into a single file (and single HTTP request) in the production environment. This is a big improvement, but it could be better. In addition to combining the files, we want to reduce the data transferred by running them through a so-called minifier, which removes whitespace, comments, and makes various optimizations like variable name substitution and function inlining. Lastly, the big challenge: we want to be able to do this on platforms like Heroku, where our ability to write to disk is highly restricted.

## Read only file systems

The biggest issue for asset packaging when deploying a Rails app to Heroku is that, with the exception of the `tmp` folder, we only have read access to the disk. This means that the `cache` option for the asset helper methods will not work, because the concatenated files are written to disk the first time they're needed. The Rails helpers also don't offer the ability to minify the output file, so we'll need to look into a plugin-based solution for asset packaging.

There are quite a few asset packaging plugins out there, including [asset_packager](https://github.com/sbecker/asset_packager), [heroku_asset_packager](https://github.com/amasses/heroku_asset_packager), [heroku_asset_cacher](https://github.com/mgomes/heroku_asset_cacher), and [Jammit](https://github.com/documentcloud/jammit/). If you Google around on the subject, you'll also find a multitude of blog posts and discussions where people have written Rake and Capistrano tasks to jury rig a solution for this problem. Clearly there is no ideal approach yet. I think Jammit has come pretty close, but it still comes up against a brick wall on Heroku's read only file system.

## Precaching

The most common suggestion I've seen is to precache the asset files, i.e., to generate them all on the local machine and commit them to the repository before deploying. With this approach, nothing needs to be written to disk in the production environment. The downside is that we now have artifacts from our build process in our repository's history, which is far less than ideal. Still, some find this to be an acceptable compromise, and all the Rake and Capistrano based solutions you'll see automate the committing of assets before deployment to make it a little less painful. If having your history dirtied doesn't bother you, you can probably stop there. Personally, I'm not satisfied yet.

## Caching or precaching to `tmp`

Unlike the built in Rails helper methods, Jammit writes the cached asset files to a special directory at `public/assets`. Using Jammit's helper `include_javascripts :some_package`, for example, will create a script tag linking to `example.com/assets/some_package.js`. On the first request to this address, the request will be routed to a special Jammit controller that will figure out which raw files need to be packaged. It will run them through either the YUI Compressor or the Google Closure Compiler, with options we specify in configuration, serve the response to the client directly, and cache the output by writing it to `assets/some_package.js`. The next time the address is requested, Rack will see that the cached file exists, and serve that instead of routing to the Jammit controller.

We are faced with two problems with this process on Heroku. The first is that we can only write to `tmp`. The second is that Heroku lacks a JVM, which is used by both the YUI Compressor and the Google Closure Compiler. Currently, Jammit doesn't offer a workaround for either of these issues. It would require a configuration option to change the full file path for the cached assets, and an alternative minifier which works without a JVM. One possible solution is [UglifyJS](https://github.com/mishoo/UglifyJS), which runs on [Node.js](https://github.com/joyent/node), and is already being used for projects like jQuery. An interface to UglifyJS and Node might be provided by [therubyracer-heroku](https://github.com/aler/therubyracer-heroku) and [Uglifier](https://github.com/lautis/uglifier).

Even if Jammit could write the cached assets to `tmp`, it's still not the best approach. `tmp` is not really intended for this purpose, as Heroku states in their documentation:

> If you wish to drop a file temporarily for the duration of the request, you can write to a filename like `#{RAILS_ROOT}/tmp/myfile_#{Process.pid}`. There is no guarantee that this file will be there on subsequent requests (although it might be), so this should not be used for any kind of permanent storage.

The good news is that Heroku provides Varnish as an HTTP cache, so we should be able to use that instead of writing to disk at all. The first request for an asset package will hit the Jammit controller, which would add HTTP caching headers to the response. The next user that requests the packaged asset file will be served directly from Varnish, completely bypassing the application stack. And when the same user loads another page that includes the same asset package, the browser won't even request the file from the server because of the HTTP caching headers that have been set. Now that's efficient.

## Busting the cache

Okay, we've got a good plan for caching asset files, but what happens when we update the content in those files? Without some intervention, the user will be served outdated content from the cache. The Rails and Jammit helpers solve this by adding a timestamp to the query string, created from the mtime of the file. After deployment, the old cached files are removed, and new ones are generated with a new cache busting string. The user's browser and Varnish will both see this as a new file, and request the new content. This is a pretty good solution, but still not totally ideal.

Because the cached assets are being recreated on every deployment, the mtime (and therefore the cache busting string) changes even if the contents of the files themselves don't change. Users are forced to redownload all the assets on the entire site again after each deploy, even if only one of them has changed. A better approach would be to use an MD5 hash of the file's contents as the cache busting string, so the query string only changes when the contents of the file change, and the asset files can stay cached across deployments. We'd probably also want some mechanism for remembering the MD5 for a particular asset file, or we'd have to get the MD5 every time a script tag was generated with one of the helper methods.

## It's a tough problem

As evidenced by the multitude of plugins and scripts which attempt to solve this problem, it's a tough nut to crack. I think the current tools are good, but still not quite up to par. I will continue to investigate this myself, and will hopefully be able to whip up some code to contribute, but I hope the Rails and Heroku communities can really work together to find a solution for asset packaging and caching on Heroku that makes things as efficient and painless as possible.
