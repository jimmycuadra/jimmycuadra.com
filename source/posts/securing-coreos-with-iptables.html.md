---
title: "Securing CoreOS with iptables"
date: "2015-01-30 00:44 PST"
tags: "coreos, devops"
---
I've been keeping a close eye on [CoreOS](https://coreos.com/) since it was originally announced, and in the last few months I've actually started using it for a few things. As a young project, CoreOS has lots of rough edges in terms of documentation and usability. One of the issues I ran into was how to secure a CoreOS machine's public network. By default, a fresh CoreOS installation has no firewall rules, allowing all inbound network traffic.

In order to secure a CoreOS machine, I had to learn how to configure the firewall. I use the common [iptables](http://www.netfilter.org/projects/iptables/) utility for this purpose. While I was vaguely familiar with iptables, I'd never really had to learn it, so I delved in to get a more thorough understanding of it. There are plenty of resources to learn iptables on the web, so I won't go into that too much here. The issue specific to CoreOS is how to configure iptables when launching a new machine.

CoreOS is unusual in that it is extremely minimal. It's designed for all programs to be run inside Linux containers, so the OS itself contains only the subsystems and tools necessary to achieve that.  iptables, however, is one of the programs that does run on the OS itself.

With a more traditional Linux distribution, it's common to launch a new instance and then provision it with a tool like Chef or Puppet. Your configuration lives in a Git repository somewhere and you run a program on the target machine after it's booted to converge it into the desired state. CoreOS is missing a lot of the infrastructure assumed to be present by tools like Chef and Puppet, so they are not supported. It is possible to run Ansible, a push-based configuration management tool, on a CoreOS host, but I'm not a fan of Ansible for reasons that are beyond the scope of this post, and plus, using a complex configuration management tool is sort of against the spirit of CoreOS, where almost everything should happen in containers.

For very minimal on-boot configuration, CoreOS supports a subset of cloud-config, the YAML-based configuration format from the [cloud-init](http://cloudinit.readthedocs.org/en/latest/index.html) tool. CoreOS instances can be provided a cloud-config file and will perform certain actions on boot. cloud-config can be used to load iptables with a list of rules for a more secure network.

I'll provide the relevant portion of the cloud-config I use on [DigitalOcean](https://www.digitalocean.com/), then explain the relevant pieces:

~~~ yaml
#cloud-config

coreos:
  units:
    - name: iptables-restore.service
      enable: true
write_files:
  - path: /var/lib/iptables/rules-save
    permissions: 0644
    owner: root:root
    content: |
      *filter
      :INPUT DROP [0:0]
      :FORWARD DROP [0:0]
      :OUTPUT ACCEPT [0:0]
      -A INPUT -i lo -j ACCEPT
      -A INPUT -i eth1 -j ACCEPT
      -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
      -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
      -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
      -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
      -A INPUT -p icmp -m icmp --icmp-type 0 -j ACCEPT
      -A INPUT -p icmp -m icmp --icmp-type 3 -j ACCEPT
      -A INPUT -p icmp -m icmp --icmp-type 11 -j ACCEPT
      COMMIT
~~~

Every cloud-config file must start with `#cloud-config` exactly. I learned the hard way that this is not just a comment – it actually tells CoreOS to treat the file as a cloud-config. Otherwise it will assume it's a shell script and just run it as such.

The following lines are [YAML](http://www.yaml.org/) syntax. The `coreos` section is a CoreOS-specific extension to cloud-init's cloud-config format. The `units` section within it will automatically perform the specified action(s) on the specified [systemd](http://www.freedesktop.org/wiki/Software/systemd/) units. systemd is the init system used by CoreOS, and many of the OS's core operations are tied closely to it. "Units" are essentially processes that are managed by systemd and represented on disk by unit files that define how the unit should behave.

The systemd unit `iptables-restore.service` ships with CoreOS but is not enabled by default. `enable: true` turns it on and will cause it to run on boot after every reboot. Here are the important contents of that unit file:

~~~ ini
[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore /var/lib/iptables/rules-save
~~~

The unit file defines a "oneshot" job, meaning it simply executes and exits and is not intended to stay running permanently. The command run is the `iptables-restore` utility, which accepts an iptables script file defining rules to be loaded into iptables. Whenever the system reboots, all iptables rules are flushed and must be reloaded from this script. That's exactly what `iptables-restore` does. The script it loads is expected to live at `/var/lib/iptables/rules-save`, which brings us to the second section of the cloud-config file.

cloud-config's `write_files` section will, unsurprisingly, write files with the given content to the file system. The content field is the most important part here. This defines the iptables rules to load. The details of this configuration can be fully explained by reading the iptables documentation, but to summarize, these rules:

* Allow all input to localhost
* Allow all input on the private network interface
* Allow all connections that are currently established, which prevents existing SSH sessions from being suddenly terminated
* Allow incoming TCP traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS)
* Allow incoming ICMP traffic for echo replies, unreachable destination messages, and time exceeded messages
* Drop all other incoming traffic
* Drop all traffic attempting to forward through the network
* Allow all outbound traffic

The three TCP ports allowed are pretty standard, but those are the rules you'd be most likely to change or augment depending on what services you'll be running on your CoreOS machine.

After CoreOS boots, SSH into it, and verify that iptables was configured properly by running `sudo iptables -S` (to see it listed in the same format as above) or with `sudo iptables -nvL` (for the more standard list format).

That's pretty much it! As you can see, there are a lot of related technologies to learn when venturing into CoreOS. Several of these were new for me, so there was a lot of learning involved in getting this working. For reference, the entire cloud-config I use for CoreOS on DigitalOcean can be found in [this Gist](https://gist.github.com/jimmycuadra/fe79ae8857f3f0d0cae1).
