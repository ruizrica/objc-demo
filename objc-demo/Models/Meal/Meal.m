//
//  Meal.m
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "Meal.h"

@implementation Meal

- (id)init {
    self = [super init];
    if (self) {
        self.idMeal = @"";
        self.strMeal = @"";
        self.strMealThumb = @"";
    }
    return self;
}

+ (Meal *)parseMeal:(NSDictionary *)meal {
    Meal *mealObject = [[Meal alloc]init];
    mealObject.idMeal = [NSString stringWithFormat:@"%@",meal[@"idMeal"]];
    mealObject.strMeal = [NSString stringWithFormat:@"%@",meal[@"strMeal"]];
    mealObject.strMealThumb = [NSString stringWithFormat:@"%@",meal[@"strMealThumb"]];
    return mealObject;
}
@end
