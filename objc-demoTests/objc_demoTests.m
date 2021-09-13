//
//  objc_demoTests.m
//  objc-demoTests
//
//  Created by Kenetic Labs on 9/13/21.
//

#import <XCTest/XCTest.h>
#import "API.h"
#import "MealCategory.h"
#import "Meal.h"

#pragma mark - Block Testing
#define setupBlock() __block BOOL blockFinished = NO;
#define awaitBlock() while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !blockFinished);
#define finishedBlock() blockFinished = YES;

@interface objc_demoTests : XCTestCase

@end

@implementation objc_demoTests

- (void)testLoadCategories {
    
    setupBlock()
    [API loadCategories:^(NSDictionary * _Nonnull result) {
        NSArray *categories = result[@"objects"];
        XCTAssertTrue(categories.count > 0);
        XCTAssertTrue([result[@"objects"] isKindOfClass:[NSArray class]]);
        finishedBlock()
    }];
    awaitBlock()
}

- (void)testLoadMeals {
    
    setupBlock()
    [API loadMeals:@"Beef" withHandler:^(NSDictionary * _Nonnull result) {
        NSArray *meals = result[@"objects"];
        XCTAssertTrue(meals.count > 0);
        XCTAssertTrue([result[@"objects"] isKindOfClass:[NSArray class]]);
        finishedBlock()
    }];
    awaitBlock()
}

- (void)testLoadMeal {
    
    setupBlock()
    [API loadMeal:@"52772" withHandler:^(NSDictionary * _Nonnull result) {
        NSDictionary *meal = result[@"meals"][0];
        Meal *testMeal = [Meal parseMeal:meal];
        XCTAssertTrue([testMeal isKindOfClass:[Meal class]]);
        finishedBlock()
    }];
    awaitBlock()
}

- (void)testLoadImage {
    
    setupBlock()
    [API loadImage:@"https://www.themealdb.com/images/media/meals/gpz67p1560458984.jpg" withHandler:^(UIImage * _Nonnull result) {
        XCTAssertTrue([result isKindOfClass:[UIImage class]]);
        finishedBlock()
    }];
    awaitBlock()
}


@end
