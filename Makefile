ARCHS = armv7 arm64
TARGET = :clang
TWEAK_NAME = HUDDismiss
HUDDismiss_FILES = Tweak.xm
HUDDismiss_FRAMEWORKS = UIKit

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
