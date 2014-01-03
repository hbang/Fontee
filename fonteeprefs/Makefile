TARGET =: clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = fonteeprefs
fonteeprefs_FILES = fonteeprefs.xm
fonteeprefs_INSTALL_PATH = /Library/PreferenceBundles
fonteeprefs_FRAMEWORKS = UIKit Twitter CoreGraphics
fonteeprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/fonteeprefs.plist$(ECHO_END)
