TARGET = :clang

include theos/makefiles/common.mk

TWEAK_NAME = Fontee
Fontee_FILES = Tweak.xm
Fontee_FRAMEWORKS = UIKit
Fontee_PRIVATE_FRAMEWORKS = GraphicsServices

include $(THEOS_MAKE_PATH)/tweak.mk
