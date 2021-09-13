//
//  Theme.m
//  fetch-rewards-demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "Theme.h"
#import "Constants.h"
#import "MealCategoryCell.h"

// Local Constant
#define kOffset 120.00

@interface Theme ()

@end

@implementation Theme

+ (UIView *)drawUI_mainHeader {
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kOffset)];
    header.backgroundColor = kColor_flatGreen;
    
    float titleOffset = 30;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(titleOffset, titleOffset+5, kScreenWidth-titleOffset, 40)];
    title.font = kFont_BoldItalic_WSize(24);
    title.textColor = [UIColor whiteColor];
    title.text = @"iOS Coding Challenge";
    [header addSubview:title];
    
    UILabel *author = [[UILabel alloc]initWithFrame:CGRectMake(titleOffset, titleOffset+30, kScreenWidth-titleOffset, 40)];
    author.font = kFont_MediumItalic_WSize(14);
    author.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    author.text = @"Ricardo Ruiz";
    [header addSubview:author];
    
    UILabel *contact = [[UILabel alloc]initWithFrame:CGRectMake(titleOffset, titleOffset+50, kScreenWidth-titleOffset, 40)];
    contact.font = kFont_MediumItalic_WSize(14);
    contact.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    contact.text = @"ricardo@kenetic-labs.com";
    [header addSubview:contact];
    
    return header;
}

+ (UICollectionView *)drawUI_mainCollectionView {
    
    float offset = kOffset;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
            
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, offset, kScreenWidth, kScreenHeight-offset) collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:@"MealCategoryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor = kColor_flatBlack;
    collectionView.alwaysBounceVertical = YES;
    return collectionView;
}

+ (UIView *)drawUI_mealHeader:(NSString *)title {

    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kOffset)];
    header.backgroundColor = kColor_flatPurple;
    
    float titleOffset = 30;
    UILabel *title_lb = [[UILabel alloc]initWithFrame:CGRectMake(15, titleOffset-19, kScreenWidth-titleOffset, 40)];
    title_lb.font = kFont_BoldItalic_WSize(24);
    title_lb.textColor = [UIColor whiteColor];
    title_lb.minimumScaleFactor = 0.5;
    title_lb.text = title;
    title_lb.numberOfLines = 2;
    title_lb.lineBreakMode = NSLineBreakByWordWrapping;
    [header addSubview:title_lb];
    
    return header;
}

+ (UIView *)drawUI_recipeHeader:(NSString *)title {

    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    header.backgroundColor = kColor_flatBlue;
    
    float titleOffset = 5;
    UILabel *title_lb = [[UILabel alloc]initWithFrame:CGRectMake(15, titleOffset, kScreenWidth-titleOffset-5, 70)];
    title_lb.font = kFont_BoldItalic_WSize(20);
    title_lb.textColor = [UIColor whiteColor];
    title_lb.text = title.capitalizedString;
    title_lb.numberOfLines = 2;
    title_lb.lineBreakMode = NSLineBreakByWordWrapping;
    title_lb.minimumScaleFactor = 0.2;
    [header addSubview:title_lb];
    return header;
}

+ (UIImageView *)drawUI_recipeImageView {
    
    float xOffset = 50;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(xOffset, 90, kScreenWidth-(xOffset*2), 190)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    return imageview;
}

+ (UITextView *)drawUI_recipeInstructions {
    
    float xOffset = 20;
    float yOffset = 385;
    float buffer = 28;
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(xOffset, yOffset, kScreenWidth-(xOffset*2), kScreenHeight-yOffset-buffer)];
    textview.font = kFont_MediumItalic_WSize(15);
    textview.backgroundColor = [UIColor clearColor];
    return textview;
}

+ (UIView *)drawUI_recipeContentSection {
    
    float yOffset = 340;
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(0, yOffset, kScreenWidth, kScreenHeight-yOffset)];
    background.backgroundColor = kColor_flatBlue;
    
    UIView *ingredients = [[UIView alloc]initWithFrame:CGRectMake(0, -40, kScreenWidth, 40)];
    ingredients.backgroundColor = [kColor_flatBlue colorWithAlphaComponent:0.6];
    [background addSubview:ingredients];
    return background;
}

+ (UICollectionView *)drawUI_mealCollectionView {
    
    float offset = kOffset-60;
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
            
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, offset, kScreenWidth, kScreenHeight-offset-25) collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:@"MealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor = kColor_flatBlack;
    collectionView.alwaysBounceVertical = YES;
    return collectionView;
}

@end
