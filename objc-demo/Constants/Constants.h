//
//  Constants.h
//  demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Log Shortcut
#define kl(text) NSLog(@#text);

#pragma mark - UI Light Modes

#define kForceLightMode self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
#define kForceDarkMode self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;

#pragma mark - Default iPhone/iPad Size Constants
#define kScreenSize [[UIScreen mainScreen] bounds].size
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#pragma mark - Fonts Dynamic
#define kFont_Bold_WSize(x) [UIFont fontWithName:@"AvenirNext-Bold" size:x]
#define kFont_BoldItalic_WSize(x) [UIFont fontWithName:@"AvenirNext-BoldItalic" size:x]
#define kFont_DemiBold_WSize(x) [UIFont fontWithName:@"AvenirNext-DemiBold" size:x]
#define kFont_DemiBoldItalic_WSize(x) [UIFont fontWithName:@"AvenirNext-DemiBoldItalic" size:x]
#define kFont_Medium_WSize(x) [UIFont fontWithName:@"AvenirNext-Medium" size:x]
#define kFont_MediumItalic_WSize(x) [UIFont fontWithName:@"AvenirNext-MediumItalic" size:x]

#pragma mark - Directory Paths
#define kDocumentsDirectoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark - Colors
#define kColor_flatTurquoise [UIColor colorWithRed:26.0/255.0f green:188.0/255.0f blue:156.0/255.0f alpha:1.0]

#define kColor_flatGreen [UIColor colorWithRed:0.152 green:0.684 blue:0.373 alpha:1.000]

#define kColor_flatBlue [UIColor colorWithRed:41.0/255.0f green:128.0/255.0f blue:185.0/255.0f alpha:1.0]
#define kColor_flatDarkBlue [UIColor colorWithRed:41.0/255.0f green:128.0/255.0f blue:185.0/255.0f alpha:1.0]
#define kColor_flatMidnight [UIColor colorWithRed:44.0/255.0f green:62.0/255.0f blue:80.0/255.0f alpha:1.0]

#define kColor_flatPurple [UIColor colorWithRed:142.0/255.0f green:68.0/255.0f blue:173.0/255.0f alpha:1.0]

#define kColor_flatOrange [UIColor colorWithRed:243.0/255.0f green:156.0/255.0f blue:18.0/255.0f alpha:1.0]
#define kColor_flatRed [UIColor colorWithRed:192.0/255.0f green:57.0/255.0f blue:43.0/255.0f alpha:1.0]
#define kColor_flatSilver [UIColor colorWithRed:189.0/255.0f green:195.0/255.0f blue:199.0/255.0f alpha:1.0]
#define kColor_flatGray [UIColor colorWithRed:127.0/255.0f green:140.0/255.0f blue:141.0/255.0f alpha:1.0]
#define kColor_flatLightGray [UIColor colorWithRed:0.585 green:0.645 blue:0.653 alpha:1.000]

#define kColor_flatYellow [UIColor colorWithRed:0.917 green:0.771 blue:0.273 alpha:1.000]

#define kColor_darkGray [UIColor darkGrayColor]
#define kColor_flatBlack [UIColor colorWithRed:0.227 green:0.227 blue:0.227 alpha:1]
#define kColor_flatDarkOrange [UIColor colorWithRed:0.828 green:0.332 blue:0.000 alpha:1.000]

@interface Constants : NSObject

@end

NS_ASSUME_NONNULL_END
