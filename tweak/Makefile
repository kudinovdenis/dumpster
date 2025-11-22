ifdef ROOTLESS
$(info Build as a ROOTLESS Substrate Tweak)
THEOS_PACKAGE_SCHEME=rootless
PACKAGE_BUILDNAME := rootless
else ifdef ROOTHIDE
$(info Build as a ROOTHIDE Substrate Tweak)
# THEOS_PACKAGE_ARCH := iphoneos-arm64e # must set afterwards if using original theos
THEOS_PACKAGE_SCHEME=roothide
PACKAGE_BUILDNAME := roothide
else # ROOTLESS / ROOTHIDE
$(info Build as a ROOTFUL Substrate Tweak)
PACKAGE_BUILDNAME := rootful
endif # ROOTLESS / ROOTHIDE


ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = installd

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RubberStamp

RubberStamp_FILES = Tweak.m
RubberStamp_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "launchctl kickstart -k -p user/501/com.apple.mobile.installd"
