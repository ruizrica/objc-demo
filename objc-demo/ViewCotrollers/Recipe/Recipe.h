//
//  Recipe.h
//  demo-objc
//
//  Created by Kenetic Labs on 8/30/21.
//

#import <UIKit/UIKit.h>
#import "MealRecipe.h"
NS_ASSUME_NONNULL_BEGIN

@interface Recipe : UIViewController
@property (nonatomic,strong) MealRecipe *recipe;
@end

NS_ASSUME_NONNULL_END
