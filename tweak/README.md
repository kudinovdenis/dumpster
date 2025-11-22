# RubberStamp

Disable MinimumOSVersion verification so you can install IPA that requires higher iOS version and then use fouldecrypt to fetch executables.

## Requirements

* jailbroken iOS
* [theos](https://theos.dev/)

## Build

```sh
export ROOTLESS=1  # for rootless jailbreak
make package
THEOS_DEVICE_IP=localhost THEOS_DEVICE_PORT=2222 make install
```
