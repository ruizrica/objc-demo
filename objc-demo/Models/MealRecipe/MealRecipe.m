//
//  MealRecipe.m
//  fetch-rewards-demo-objc
//
//  Created by Kenetic Labs on 8/30/21.
//

#import "MealRecipe.h"

@implementation MealRecipe

- (id)init {
    self = [super init];
    if (self) {
        
        self.idMeal = @"";
        self.strMeal = @"";
        self.strMealThumb = @"";
        self.strSource = @"";
        self.strYoutube = @"";
        self.strInstructions = @"";
        self.strArea = @"";
        self.strCategory = @"";
        self.strDrinkAlternate = @"";
        self.ingredients = @[];
    }
    return self;
}

+ (MealRecipe *)parseMealRecipe:(NSDictionary *)mealRecipe {
        
    NSMutableArray *ingredients = [[NSMutableArray alloc]init];
    for (NSString *item in mealRecipe) {
        if ([item hasPrefix:@"strIngredient"]) {
            NSString *separator = @"nt";
            NSString *index = [item componentsSeparatedByString:separator][1];
            for (NSString *item_measure in mealRecipe) {
                if ([item_measure hasPrefix:@"strMeasure"]) {
                    NSString *separator = @"re";
                    NSString *index_measure = [item_measure componentsSeparatedByString:separator][1];
                    if ([index isEqualToString:index_measure]) {
                        @try {
                            NSString *lenTest = mealRecipe[item];
                            if (lenTest.length > 0) {
                                [ingredients addObject:@{mealRecipe[item] : mealRecipe[item_measure]}];
                            }
                        } @catch (NSException *exception) {
                            NSLog(@"Current Item is nil... Ignoring...");
                        }
                        
                    }
                }
            }
        }
    }

    MealRecipe *mealObject = [[MealRecipe alloc]init];
    mealObject.idMeal = [NSString stringWithFormat:@"%@",mealRecipe[@"idMeal"]];
    mealObject.strMeal = [NSString stringWithFormat:@"%@",mealRecipe[@"strMeal"]];
    mealObject.strMealThumb = [NSString stringWithFormat:@"%@",mealRecipe[@"strMealThumb"]];
    mealObject.strSource = [NSString stringWithFormat:@"%@",mealRecipe[@"strSource"]];
    mealObject.strYoutube = [NSString stringWithFormat:@"%@",mealRecipe[@"strYoutube"]];
    mealObject.strInstructions = [NSString stringWithFormat:@"%@",mealRecipe[@"strInstructions"]];
    mealObject.strArea = [NSString stringWithFormat:@"%@",mealRecipe[@"strArea"]];
    mealObject.strCategory = [NSString stringWithFormat:@"%@",mealRecipe[@"strCategory"]];
    mealObject.strDrinkAlternate = [NSString stringWithFormat:@"%@",mealRecipe[@"strDrinkAlternate"]];
    mealObject.ingredients = ingredients;
    return mealObject;
}

@end
