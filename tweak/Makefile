#SDKVERSION = 18.4
TARGET := iphone:clang:latest:16.0:rootless
ARCHS = arm64

THEOS_PACKAGE_SCHEME = rootless
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UniqueNameSimpleTweak

UniqueNameSimpleTweak_FILES = Tweak.x
UniqueNameSimpleTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
