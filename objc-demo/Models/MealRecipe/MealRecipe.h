//
//  MealRecipe.h
//  fetch-rewards-demo-objc
//
//  Created by Kenetic Labs on 8/30/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MealRecipe : NSObject
@property (nonatomic,strong) NSString *idMeal;
@property (nonatomic,strong) NSString *strMeal;
@property (nonatomic,strong) NSString *strMealThumb;
@property (nonatomic,strong) NSString *strSource;
@property (nonatomic,strong) NSString *strYoutube;
@property (nonatomic,strong) NSString *strInstructions;
@property (nonatomic,strong) NSString *strArea;
@property (nonatomic,strong) NSString *strCategory;
@property (nonatomic,strong) NSString *strDrinkAlternate;
@property (nonatomic,strong) NSArray *ingredients;
+ (MealRecipe *)parseMealRecipe:(NSDictionary *)mealRecipe;
@end

NS_ASSUME_NONNULL_END
