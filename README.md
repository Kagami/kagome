## kagome — application cage

### What is this all about?

`kagome` is a collection of scripts helps to run programs in Linux in isolated environments.

As for now this repository doesn't provide installer or similar product-ready installation guide. It's just an example on how to make your desktop more secure by running each program in their own isolate environments. Though this may change in future.

### Project motivation or why should I care?

Indeed, why the hell someone should invent crazy methods to run programs? Err, docker? And anyway, *Linux doesn't have viruses*, does it? I'm already overprotected just by running Ubuntu!

Well, it's true that Linux isn't the most popular desktop operating system. Though it *does have* viruses and there are a lof of blackhats who regularly search security holes in Linux programs. Even if their attack will not target just you, you still be nice link of huge botnet chain.

By the way do you now what in Linux:
* Almost every major browser update contains a lot of security issues fixes (read the changelog)
* This is not a big deal to have remote code execution issues in such programs as Adobe Flash and Oracle Java (google it)
* Even if you regularly update your system can you say what criminals do with their exploits *before* you've installed the fix?
* You're in a big risk if you run browser (or other untrustworthy program) from the same user as other programs and in the same X server (and I'm sure you are) because:
  * Owner of the remote code exploit for browser will have access to all your files
  * Could see all your other programs, their window content and so on
  * And much worse [could listen all your key events](http://theinvisiblethings.blogspot.ru/2011/04/linux-security-circus-on-gui-isolation.html) in all windows and catch sudo password when you will type it in a terminal (try it by yourself: `xev -id <windowid>`)
  * In other words your system could be easily compromised and you even won't know about it

If even this doesn't hesitate you then maybe you should read [Nothing to hide](http://papers.ssrn.com/sol3/papers.cfm?abstract_id=998565) ([russian translation](https://www.pgpru.com/biblioteka/statji/nothingtohide)) or ~~just buy the MacBook~~ (joke).

*TODO*: Add more links to security holes to make you scared.

### Proposal or what do you suggest?

So one of the solution of running extremely buggy software along with the sensitive data at the same machihe is to use sandboxes. This idea is not new though virtualization field and especially the lightweight containers gained broad attention recently and make things much easier:
* [Namespaces support](http://lwn.net/Articles/531114/) merged into Linux mainline
* [Docker](https://www.docker.com/) appearance which brings:
  * Convenient layer filesystem using aufs
  * Tons of pre-created images in [registry](https://registry.hub.docker.com/)

The main concept of `kagome` is to run all your applications in separate lightweight Linux containers with separate filesystem and X server.

### Other concepts and their criticism

##### [subuser](https://github.com/subuser-security/subuser)

In many ways `subuser` very similar to `kagome` but has some design flaws:
* Uses same X server for running GUI programs
* Has very dangerous options enabled by default (e.g. inherit-working-directory)
* Doesn't use user namespaces
* Doesn't warn you what adding user to the docker group is [rather dangerous](https://docs.docker.com/articles/security/#docker-daemon-attack-surface)

So despite the fact what `subuser` is more user-friendly for the end user it doesn't make your life much easier.

##### Well-tuned [MAC](https://en.wikipedia.org/wiki/Mandatory_access_control) ([SELinux](http://selinuxproject.org/page/Main_Page)/[AppArmor](http://wiki.apparmor.net/index.php/Main_Page)) or [DAC](https://en.wikipedia.org/wiki/Discretionary_access_control)

Someone may suggest SELinux or other MAC implementation. Indeed, isn't such mechanisms should solve this kind of problems instead of doubtful reinventing the wheel with the containers? Well, partly this is true though SELinux has it's own disadvantages:
* Very complex for the end user, you should know a lot about the system *and* about the program you want to run
* Even if you have good and tuned SELinux rules for all your applications it's still unclear on how to make several instances of the same application (e.g. different browser profiles) isolated from each other

On the other hand if we assume for a moment that container isolation is unbreakable then we may don't care about application details at all: just run it inside the sandbox and do you work. In other words: with SELinux it's a lot of work for each application, with VM/container you just run inside whatever you want.

By the way we could use MAC rules for Docker/LXC to make it harder to break container isolation.

##### Hardening your [kernel](https://grsecurity.net/) or [userland](http://cr.yp.to/qmail/guarantee.html) or [both](http://www.openbsd.org/)

While writting software *in a right way* seems to be right thing to do, the world is a terrible imperfect place. In my opinion it's better to assume what you run bad programs on bad OS on bad hardware (and find the ways to workaround it) than try to make everything you touch unbuggy and perfect.

Though it's perfectly fine and good to use grsecurity/PaX-enabled kernel. Just don't rely on it as one and only security measure.

##### [Qubes OS](https://wiki.qubes-os.org/)

Let's think about virtualization for a moment: why do we need containers when we already have much more robust KVM/XEN/VirtualBox hypervisors? The answer is one word: *overhead*. You just can't run dozens of KVM guests on an average desktop box while there could be hundreds of containers without much troubles.

Even more, how do you plan to support/upgrade/fix operating systems in all of your guests? If you eventually come with the Vagrant & Puppet/Chef it's still a lof of hard work. And I don't think what anyone will be excited to spend so much effort just into single desktop.

Qubes OS tries to solve both of this problems though it's still very expiremental and you can't install it into your current system (it's separate Linux distribution). Although I don't know much details about implementation (e.g. how do they solve memory overhead because [deduplication seems to be disabled](https://groups.google.com/d/msg/qubes-devel/tfMk_g7Y1tQ/iSLQ2jNyZH8J)) I think this is very promising OS and definetely going to investigate into it further.

##### See also

* [The three approaches to computer security](http://theinvisiblethings.blogspot.ru/2008/09/three-approaches-to-computer-security.html)
* [Containers & Docker: How Secure Are They?](http://blog.docker.com/2013/08/containers-docker-how-secure-are-they/)

### Design overview or how much secure is it?

* Docker as for container implementation and images ecosystem
* Separate user for interaction with Docker via wrapper scripts
* Xephyr for guest X servers running into host X server as X clients
* Separate container and filesystem for each program/sets of programs, separate X server for each GUI program
* Program profiles for different tasks lays in separate container and can't interfere with each other
* CLI environments are grouped by the set of tasks
* Programs inside the containers run from a non-root user
* Containers see only their own persistent data

Possible security flaws (see also TODO section):
* Container→host system escalation (could be reduced with the user namespaces, planning Docker feature to run in from a non-root user and proper MAC rules)
* Xephyr→host system escalation (could be reduced with the proper MAC rules)
* Wrapper script escalation (Docker should allow to run itself from a non-root in near future)
* Container program can send sensitive data over the net (could be reduced with the properly configured container network)

*Summing it up*: though as for now implementation is far from ideal it should be more trust-worthy in near future. And theoretically breakable sandbox is much better than no isolation at all.

*TODO*: Graphical overview.

### Usage

1. Install the tmux, Xephyr and Docker.

1. Create user `kagome` and `/home/kagome` directory, add it to the `docker` group:
  ```bash
  $ useradd kagome -s /bin/false -m -k /dev/null
  $ chown user:user /home/kagome/
  $ gpasswd -a kagome docker
  ```

1. Clone this repo, copy wrapper scripts to somewhere inside the PATH:
  ```bash
  $ git clone https://github.com/Kagami/kagome.git && cd kagome
  $ cp scripts/* /usr/local/bin/
  ```

1. Add ability to run wrapper scripts for your user:
  ```bash
  $ visudo
  ...
  user ALL=(kagome) NOPASSWD: /usr/local/bin/docker-run
  user ALL=(kagome) NOPASSWD: /usr/bin/docker build *
  user ALL=(kagome) NOPASSWD: /usr/bin/docker images
  user ALL=(kagome) NOPASSWD: /usr/bin/docker pull *
  user ALL=(kagome) NOPASSWD: /usr/bin/docker rmi *
  user ALL=(kagome) NOPASSWD: /usr/bin/docker rm *
  ...
  ```

1. Go to the `images` dir, fix Dockerfiles for your needs, build images with `make image1 image2 ...` (don't forget to pull needed base images with `docker pull`, e.g. `docker pull ubuntu:latest`).

1. Create `/etc/conf.d` directory, config for your first containerized application and symlink `kagome-gui` script to make runnable:
  ```bash
  $ mkdir -p /home/kagome/home/firefox/
  $ mkdir /etc/conf.d/
  $ cat >/etc/conf.d/firefox-home <<EOF
  IMAGE=gui-nonfree
  APP=firefox
  MOUNTS=/home/kagome/home/firefox:/home/user/.mozilla
  SOUND=y
  EOF
  $ ln -s /usr/local/bin/kagome-gui /usr/local/bin/firefox-home
  ```

1. Run `firefox-home` from you main user inside the X session and enjoy!

*TODO*: Write human-friendly CLI utility for managing containers configs.

### Enhancing security tips

* Use different containers for each task (Work, Home, Tmp, etc.)
* [Disable inter-container communication](https://docs.docker.com/articles/networking/#communication-between-containers) in Docker
* Mount all partitions except root with nosuid,nodev
* Mount all user-writable partitions with noexec
* Never enter any user passwords inside the X session
* Optional: remove you main user from the sudo/admin/wheel groups and login as root only from the virtual console
* <http://wiki.centos.org/HowTos/OS_Protection>

### TODO

* ~~Fix access to sound card~~
* ~~Fix alsa "device or resource busy" issue~~ Support for PulseAudio?
* Option for disabling/configuring container network (firewall?)
* [Support for OpenGL?](http://habrahabr.ru/post/240509/#comment_8079117)
* Leverage user namespaces
* Leverage SELinux/AppArmor policies for Docker and Xephyr
* More documentation and links
* Installer and proper configuration
* `kagome` utility
* Share popular kagome images via Docker registry

### License

kagome - application cage

Written in 2014 by Kagami Hiiragi <kagami@genshiken.org>

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
