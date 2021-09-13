//
//  Theme.h
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Theme : NSObject
+ (UIView *)drawUI_mainHeader;
+ (UIView *)drawUI_mealHeader:(NSString *)title;
+ (UIView *)drawUI_recipeHeader:(NSString *)title;
+ (UICollectionView *)drawUI_mainCollectionView;
+ (UICollectionView *)drawUI_mealCollectionView;
+ (UIImageView *)drawUI_recipeImageView;
+ (UITextView *)drawUI_recipeInstructions;
+ (UIView *)drawUI_recipeContentSection;
@end

NS_ASSUME_NONNULL_END
