//
//  Meal.h
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject
@property (nonatomic,strong) NSString *idMeal;
@property (nonatomic,strong) NSString *strMeal;
@property (nonatomic,strong) NSString *strMealThumb;
+ (Meal *)parseMeal:(NSDictionary *)meal;
@end

NS_ASSUME_NONNULL_END
