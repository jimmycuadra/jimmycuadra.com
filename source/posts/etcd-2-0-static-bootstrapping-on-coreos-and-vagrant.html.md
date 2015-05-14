---
title: etcd 2.0 static bootstrapping on CoreOS and Vagrant
date: 2015-02-05 00:00 PDT
tags: coreos, devops, vagrant, etcd
---

## The problem

[CoreOS](https://coreos.com/) provides a pretty good setup for running a cluster of machines with [Vagrant](https://www.vagrantup.com/). You can find this setup at [coreos/coreos-vagrant](https://github.com/coreos/coreos-vagrant). Something I've found annoying, however, is that whenever you start a new cluster, you need to get a new discovery token from CoreOS's [hosted discovery service](https://coreos.com/docs/cluster-management/setup/cluster-discovery/). This is necessary for the [etcd](https://github.com/coreos/etcd) instances running on each machine to find each other and form a quorum. The discovery token is written to the machines on initial boot via the cloud-config file named `user-data`. If you destroy the machines and recreate them, you need to use a fresh discovery token. This didn't sit right with me, as I want to check everything into version control, and didn't want to have a lot of useless commits changing the discovery token every time I recreated the cluster.

## The solution

Fortunately, etcd doesn't rely on the hosted discovery service. You can also bootstrap etcd statically if you know the IPs and ports everything will be running on in advance. It turns out that CoreOS's Vagrantfile is already configured to provide a static IP to each machine, so these IPs can simply be hardcoded into the cloud-config. There's one more snag, which is that etcd 0.4.6 (the one that currently ships in CoreOS) gets confused if the list of IPs you include when bootstrapping includes the current machine. That would mean that the cloud-config for each machine would have to be slightly different because it'd have to include the whole list, minus itself. Without introducing an additional layer of abstraction of your own, there isn't an easy way to provide a dynamic cloud-config file that would do this. Fortunately, the [newly released etcd 2.0.0](https://coreos.com/blog/etcd-2.0-release-first-major-stable-release/) improves on the static bootstrapping story by allowing you to provide the full list of IPs on every machine. Because etcd 2.0 doesn't ship with CoreOS yet, we'll run it in a container.

For this example, we'll use a cluster of three machines, just to keep the cloud-config a bit shorter. Five machines is the recommended size for most uses. Assuming you already have Vagrant and VirtualBox installed, clone the [coreos/coreos-vagrant](https://github.com/coreos/coreos-vagrant) repository and copy `config.rb.sample` to `config.rb`. Open `config.rb` and uncomment `$num_instances`, setting its value to `3`.

~~~ ruby
# Size of the CoreOS cluster created by Vagrant
$num_instances = 3
~~~

Next, create a new file called `user-data` with the following contents:

~~~ yaml
#cloud-config

coreos:
  fleet:
    etcd-servers: http://$private_ipv4:2379
    public-ip: $private_ipv4
  units:
    - name: etcd.service
      command: start
      content: |
        Description=etcd 2.0
        After=docker.service

        [Service]
        EnvironmentFile=/etc/environment
        TimeoutStartSec=0
        SyslogIdentifier=writer_process
        ExecStartPre=-/usr/bin/docker kill etcd
        ExecStartPre=-/usr/bin/docker rm etcd
        ExecStartPre=/usr/bin/docker pull quay.io/coreos/etcd:v2.0.0
        ExecStart=/bin/bash -c "/usr/bin/docker run \
          -p 2379:2379 \
          -p 2380:2380 \
          --name etcd \
          -v /opt/etcd:/opt/etcd \
          -v /usr/share/ca-certificates/:/etc/ssl/certs \
          quay.io/coreos/etcd:v2.0.0 \
          -data-dir /opt/etcd \
          -name %H \
          -listen-client-urls http://0.0.0.0:2379 \
          -advertise-client-urls http://$COREOS_PRIVATE_IPV4:2379 \
          -listen-peer-urls http://0.0.0.0:2380 \
          -initial-advertise-peer-urls http://$COREOS_PRIVATE_IPV4:2380 \
          -initial-cluster core-01=http://172.17.8.101:2380,core-02=http://172.17.8.102:2380,core-03=http://172.17.8.103:2380\
          -initial-cluster-state new"
        ExecStop=/usr/bin/docker kill etcd

        [X-Fleet]
        Conflicts=etcd*
    - name: fleet.service
      command: start
~~~

Now just run `vagrant up` and in a few minutes you'll have a cluster of three CoreOS machines running etcd 2.0 with no discovery token needed!

If you want to run `fleetctl` inside one of the CoreOS VMs, you'll need to set the default etcd endpoint, because the current fleet still expects etcd to be on port 4001:

~~~ bash
export FLEETCTL_ENDPOINT=http://127.0.0.1:2379
~~~

If you don't care about how that all works and just want a working cluster, you can stop here. If you want to understand the guts of that cloud-config more, keep reading.

## The details

One of the changes in CoreOS 2.0 is that it now uses port 2379 and 2380 (as opposed to etcd 0.4.6 which used 4001 and 7001.) The `fleet` section of the cloud-config tells fleet how to connect to etcd. This is necessary because the version of fleet that ships with CoreOS now still defaults to port 4001. Once etcd 2.0 is shipping in CoreOS, I'm sure fleet will be updated to match.

The `units` section of the cloud-config creates systemd units that will be placed in `/etc/systemd/system/` on each machine. CoreOS ships with a default unit file for etcd, but we overwrite it here (simply by using the same service name, etcd.service) to use etcd 2.0 with our own configuration.

The bulk of the cloud-config is the etcd.service unit file. Most of it is the same as a standard CoreOS unit file for a Docker container. The interesting bits are the arguments to the etcd process that runs in the container:

* `-listen-client-urls`: This is the interface and port that the current machine's etcd should bind to for the client API, e.g. etcdctl. It's set to 0.0.0.0 to bind it to all interfaces, and it uses port 2379 which is the standard port, beginning in etcd 2.0.
* `-advertise-client-urls`: This is the list of URLs etcd will announce as available for clients to contact.
* `-listen-peer-urls`: Similar to the client URL version, this defines how the peer service should bind to the network. Again, we bind it to all interfaces and use the standard peer port of 2380.
* `-initial-advertise-peer-urls`: Similar to the client version, this defines how etcd will announce its peer service to other etcd processes on other machines.
* `-initial-cluster`: This is the secret sauce that keeps us from having to use a discovery token. We provide a list of each etcd service running in our cluster, mapping each machine's hostname to its etcd peer URL. Because we know which IP addresses Vagrant is going to use, we can simply enumerate them here. If you were running a cluster of a different size, this is where you would add or remove machines from the list.
* `-initial-cluster-state`: A value of `new` here tells etcd that it's joining a brand new cluster. If you were to later add another machine to the existing cluster, you'd change the value here in that machine's cloud-config.

It's worth noting that the arguments that begin with "initial" are just that: data that etcd needs in order to boot the first time. Once the cluster has booted once and formed a quorum, these arguments will be ignored on subsequent boots, because everything etcd needs to know will have been stored in its data directory (`/opt/etcd`) in this case.

This is all pretty complicated, but it will get easier once etcd 2.0 and a compatible fleet are shipped with CoreOS itself. Then the built-in etcd.service unit can be used again, and all the configuration options can be written in YAML format just like the `fleet` section in this particular cloud-config.
