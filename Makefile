TARGET = :clang
ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = Fontee
Fontee_FILES = Tweak.xm Tweak7.xm
Fontee_FRAMEWORKS = UIKit
Fontee_PRIVATE_FRAMEWORKS = GraphicsServices UIFoundation

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += fonteeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

internal-after-install::
	install.exec "killall -9 backboardd"