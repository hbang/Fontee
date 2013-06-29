#include <substrate.h>
#import <GraphicsServices/GraphicsServices.h>

BOOL forceUltraLight = NO;

static GSFontRef (*HBFTOldGSCreateFontWithName)(const char *fontName, GSFontTraitMask traits, CGFloat fontSize);

GSFontRef HBFTNewGSCreateFontWithName(const char *fontName, GSFontTraitMask traits, CGFloat fontSize) {
	if (fontName == NULL || (fontName != NULL && (
		strcmp(fontName, "Helvetica") == 0 || strcmp(fontName, "Helvetica-Bold") == 0 ||
		strcmp(fontName, "Helvetica-Italic") == 0 || strcmp(fontName, "Helvetica-BoldItalic") == 0 ||
		strcmp(fontName, "Helvetica Neue") == 0 || strcmp(fontName, "HelveticaNeue") == 0 ||
		strcmp(fontName, "HelveticaNeue-Bold") == 0 || strcmp(fontName, "HelveticaNeue-Italic") == 0 ||
		strcmp(fontName, "HelveticaNeue-BoldItalic") == 0 || strcmp(fontName, "HelveticaNeue-Light") == 0 ||
		strcmp(fontName, ".Helvetica NeueUI") == 0 || strcmp(fontName, ".HelveticaNeueUI") == 0 ||
		strcmp(fontName, ".PhoneKeyCaps") == 0 || strcmp(fontName, ".PhoneKeyCapsTwo") == 0
	))) {
		if (forceUltraLight || (fontName != NULL && (strcmp(fontName, ".PhoneKeyCaps") == 0 || strcmp(fontName, ".PhoneKeyCapsTwo") == 0))) {
			return HBFTOldGSCreateFontWithName("HelveticaNeue-UltraLight", traits, fontSize);
		} else if (traits == GSBoldFontMask + GSItalicFontMask || (fontName != NULL && (strcmp(fontName, "Helvetica-BoldItalic") == 0 || strcmp(fontName, "HelveticaNeue-BoldItalic") == 0))) {
			return HBFTOldGSCreateFontWithName("HelveticaNeue", GSItalicFontMask, fontSize);
		} else if (traits == GSBoldFontMask || (fontName != NULL && (strcmp(fontName, "Helvetica-Bold") == 0 || strcmp(fontName, "HelveticaNeue-Bold") == 0))) {
			return HBFTOldGSCreateFontWithName("HelveticaNeue", kGSFontTraitNone, fontSize);
		} else {
			return HBFTOldGSCreateFontWithName("HelveticaNeue-Light", traits, fontSize);
		}
	} else {
		return HBFTOldGSCreateFontWithName(fontName, traits, fontSize);
	}
}

%group SBHooks
%hook TPLCDTextView
- (void)drawRect:(CGRect)rect {
	forceUltraLight = YES;
	UIFont *font = MSHookIvar<UIFont *>(self, "_font");
	object_setInstanceVariable(self, "_font", [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:font.pointSize]);
	%orig;
	forceUltraLight = NO;
}
%end

%hook TPLockTextView
- (id)initWithLabel:(id)arg1 fontSize:(float)arg2 trackWidthDelta:(float)arg3 {
	forceUltraLight = YES;
	self = %orig;
	forceUltraLight = NO;
	return self;
}

- (void)drawRect:(CGRect)rect {
	forceUltraLight = YES;
	UIFont *font = MSHookIvar<UIFont *>(self, "_labelFont");
	object_setInstanceVariable(self, "_labelFont", [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:font.pointSize]);
	%orig;
	forceUltraLight = NO;
}
%end
%end

%ctor {
	MSHookFunction(GSFontCreateWithName, HBFTNewGSCreateFontWithName, &HBFTOldGSCreateFontWithName);

	if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
		%init(SBHooks);
	}
}
