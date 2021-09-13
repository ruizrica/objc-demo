//
//  API.m
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "API.h"
#import "Constants.h"
#import "MealCategory.h"
#import "MealRecipe.h"
#import "Meal.h"

#pragma mark - Local Constants
#define kAPI_categories @"https://www.themealdb.com/api/json/v1/1/categories.php" // List all meal categories
#define kAPI_meals @"https://www.themealdb.com/api/json/v1/1/filter.php?c=" // Filter by Category
#define kAPI_meal @"https://www.themealdb.com/api/json/v1/1/lookup.php?i=" // Look up meal by ID

@implementation API

+ (void)loadCategories:(apiHandler)handler {
    
    @try {
        NSError *error = nil;
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@",kAPI_categories];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"GET";

        if (!error) {
            NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]; NSLog(@"RAW Result: %@",resultsDictionary);
                NSArray *categories = resultsDictionary[@"categories"];
                NSMutableArray *categoryObjects = [[NSMutableArray alloc]init];
                for (NSDictionary *object in categories) {
                    MealCategory *category = [MealCategory parseCategory:object];
                    [categoryObjects addObject:category];
                }
                [categoryObjects sortUsingDescriptors:
                 @[[NSSortDescriptor sortDescriptorWithKey:@"strCategory" ascending:YES]]];
                handler(@{@"objects":categoryObjects});
            }];
            [task resume];
        } else {
            handler(@{@"error":error});
        }
    } @catch (NSException *exception) {
        NSLog(@"Error Loading Categories: %@",exception);
    }
}

+ (void)loadMeals:(NSString *)category withHandler:(apiHandler)handler {
    
    @try {
        NSError *error = nil;
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@",kAPI_meals];
        [urlString appendString:[NSString stringWithFormat:@"%@",category]];

        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"GET";

        if (!error) {
            NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSArray *meals = resultsDictionary[@"meals"];
                NSMutableArray *mealObjects = [[NSMutableArray alloc]init]; 
                for (NSDictionary *object in meals) {
                    Meal *meal = [Meal parseMeal:object];
                    [mealObjects addObject:meal];
                }
                [mealObjects sortUsingDescriptors:
                 @[[NSSortDescriptor sortDescriptorWithKey:@"strMeal" ascending:YES]]];
                handler(@{@"objects":mealObjects});
            }];
            [task resume];

        } else {
            handler(@{@"error":error});
        }
    } @catch (NSException *exception) {
        NSLog(@"Error Loading Categories: %@",exception);
    }
}

+ (void)loadMeal:(NSString *)mealID withHandler:(apiHandler)handler {
    
    @try {
        NSError *error = nil;
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@",kAPI_meal];
        [urlString appendString:[NSString stringWithFormat:@"%@",mealID]];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"GET";

        if (!error) {
            NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"RAW FROM MEAL: %@",resultsDictionary);
                MealRecipe *recipe = [MealRecipe parseMealRecipe:resultsDictionary[@"meals"][0]];
                handler(@{@"recipe":recipe});
            }];
            [task resume];

        } else {
            handler(@{@"error":error});
        }
    } @catch (NSException *exception) {
        NSLog(@"Error Loading Categories: %@",exception);
    }
}

+ (void)loadImage:(NSString *)url withHandler:(imageHandler)handler {
    
    @try {
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                handler([UIImage imageWithData:data]);
            }
        }];
        [task resume];
    } @catch (NSException *exception) {
        NSLog(@"Error Loading Image: %@",exception);
    }
}

@end
