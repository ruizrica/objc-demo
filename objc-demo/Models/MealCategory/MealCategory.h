//
//  MealCategory.h
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MealCategory : NSObject
@property (nonatomic,strong) NSString *idCategory;
@property (nonatomic,strong) NSString *strCategory;
@property (nonatomic,strong) NSString *strCategoryDescription;
@property (nonatomic,strong) NSString *strCategoryThumb;
+ (MealCategory *)parseCategory:(NSDictionary *)mealCategory;
@end

NS_ASSUME_NONNULL_END
