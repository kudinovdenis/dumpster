# Simple tweak for installd

Disable MinimumOSVersion verification so you can install IPA that requires higher iOS version and then use fouldecrypt to fetch executables.

## Requirements

* jailbroken iPhone
* [theos](https://theos.dev/)

## Build

This tweak built for rootless JB (palera1n).

```sh
make package
```

Could be installed by transfering to device (with rsync) and then installed with `dpkg -i`
command example to transfer: 
```sh
rsync -avz -e 'ssh -o ProxyCommand="inetcat 44" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --rsync-path='/var/jb/usr/bin/rsync' ./packages/com.a.uniquenamesimpletweak_0.0.1-2+debug_iphoneos-arm.deb mobile@127.0.0.1:/tmp/
```

