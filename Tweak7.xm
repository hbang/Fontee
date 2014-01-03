#include <substrate.h>
#import <UIKit/UIFont.h>

/* iOS 7 and above */
@interface UIFont (Private)
+(UIFont *)_ultraLightSystemFontOfSize:(float)arg1;
+(UIFont *)_lightSystemFontOfSize:(float)arg1;
//+(UIFont *)systemFontOfSize:(float)arg1;
@end

/*@interface NSFont : UIFont
+(id)fontWithName:(id)arg1 size:(float)arg2;
@end*/

%hook UIFont
static BOOL boldToSystem, systemToLight;

+(id)_lightSystemFontOfSize:(float)arg1{
	if(systemToLight){
		systemToLight = NO;
		return %orig;
	}

	return [UIFont _ultraLightSystemFontOfSize:arg1];
}

+(id)systemFontOfSize:(float)arg1{
	systemToLight = YES;
	if(boldToSystem){
		boldToSystem = NO;
		return %orig;
	}

	return [UIFont _lightSystemFontOfSize:arg1];
}

+(id)boldSystemFontOfSize:(float)arg1{
	boldToSystem = YES;
	return [UIFont systemFontOfSize:arg1];
}
%end