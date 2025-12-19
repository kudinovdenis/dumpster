# dumpster

Tool that allows you to decrypt ipa up to iOS 26 from jailbroken device with iOS 16.x by patching installd.

## Prerequisites

### iPhone
* Jailbroken iPhone logged in with your apple id account.
* Installed [tweak for installd](tweak/README.md)

### macOS device
* installed Apple Configurator to get encrypted ipa for your apple id
* [libimobiledevice](https://libimobiledevice.org/)
* [ideviceinstaller](https://github.com/libimobiledevice/ideviceinstaller)
* Python and [uv](https://docs.astral.sh/uv/)

## Set Up SSH

Edit `~/.ssh/config` to add your device as a host, for example:

```
Host ios
    LogLevel ERROR
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ProxyCommand inetcat 44
    User mobile
```

## Workflow

Download ipa with Apple Configurator or ipatool. Then

`uv run main.py app.ipa mobile@ios`

If all goes well, the result will be in app.decrypted.ipa
