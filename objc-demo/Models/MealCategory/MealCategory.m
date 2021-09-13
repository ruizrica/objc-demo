//
//  MealCategory.m
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "MealCategory.h"

@implementation MealCategory

- (id)init {
    self = [super init];
    if (self) {
        self.idCategory = @"";
        self.strCategory = @"";
        self.strCategoryDescription = @"";
        self.strCategoryThumb = @"";
    }
    return self;
}

+ (MealCategory *)parseCategory:(NSDictionary *)category {
    MealCategory *categoryObject = [[MealCategory alloc]init];
    categoryObject.idCategory = [NSString stringWithFormat:@"%@",category[@"idCategory"]];
    categoryObject.strCategory = [NSString stringWithFormat:@"%@",category[@"strCategory"]];
    categoryObject.strCategoryDescription = [NSString stringWithFormat:@"%@",category[@"strCategoryDescription"]];
    categoryObject.strCategoryThumb = [NSString stringWithFormat:@"%@",category[@"strCategoryThumb"]];
    return categoryObject;
}
@end
