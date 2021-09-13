//
//  API.h
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Completion Block
typedef void(^apiHandler)(NSDictionary *result);
typedef void(^imageHandler)(UIImage *result);

@interface API : NSObject
+ (void)loadCategories:(apiHandler)handler;
+ (void)loadMeals:(NSString *)category withHandler:(apiHandler)handler;
+ (void)loadMeal:(NSString *)mealID withHandler:(apiHandler)handler;
+ (void)loadImage:(NSString *)url withHandler:(imageHandler)handler;
@end

NS_ASSUME_NONNULL_END
