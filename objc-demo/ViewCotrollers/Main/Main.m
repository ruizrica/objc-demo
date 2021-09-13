//
//  Main.m
//  demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "Main.h"
#import "API.h"
#import "Theme.h"
#import "Constants.h"
#import "MealCategoryCell.h"
#import "MealCategory.h"
#import "Meals.h"

@interface Main () <UICollectionViewDelegate, UICollectionViewDataSource>

// UI Elements
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *header;

// Main Collection
@property (nonatomic,strong) NSArray *currentCollection;

@end

@implementation Main

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawUI];
}

- (void)drawUI {
    
    kForceDarkMode;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.view.backgroundColor = kColor_flatBlack;
        
        self.header = [Theme drawUI_mainHeader];
        [self.view addSubview:self.header];
        
        self.collectionView = [Theme drawUI_mainCollectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.view addSubview:self.collectionView];
    });
    
    [API loadCategories:^(NSDictionary * _Nonnull result) {
        self.currentCollection = (NSArray *)result[@"objects"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

#pragma mark - CollectionView Data Source & Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    int count = 0;
    if (self.currentCollection.count == 0) {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        noDataLabel.text = @"Loading...".uppercaseString;
        noDataLabel.textColor = [kColor_flatYellow colorWithAlphaComponent:0.70];
        noDataLabel.font = [UIFont fontWithName:@"AvenirNext-BoldItalic" size:20.0f];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        collectionView.backgroundView = noDataLabel;
    } else {
        count = 1;
        collectionView.backgroundView = nil;
    }
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MealCategory *target = [self.currentCollection objectAtIndex:indexPath.row];
    MealCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kColor_darkGray;
    cell.label.text = [NSString stringWithFormat:@"%@",target.strCategory];
    cell.textDescription.text = [NSString stringWithFormat:@"%@",target.strCategoryDescription];
    cell.imageview.image = nil;
    cell.backgroundImageView.image = nil;
    [API loadImage:target.strCategoryThumb withHandler:^(UIImage * _Nonnull result) {
        if (result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageview.image = result; 
                cell.backgroundImageView.image = result;
            });
        } else {
            NSLog(@"Error Loading Image...");
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 137);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    @try {
        MealCategory *category = [self.currentCollection objectAtIndex:indexPath.row];
        [API loadMeals:category.strCategory withHandler:^(NSDictionary * _Nonnull result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *mealObjects = result[@"objects"];
                Meals *meals = [[Meals alloc]init];
                meals.textTitle = category.strCategory;
                meals.currentCollection = mealObjects;
                meals.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:meals animated:YES completion:nil];
            });
        }];
        NSLog(@"Selected: %@",category.strCategory);
    } @catch (NSException *exception) {
        NSLog(@"exception: %@",exception);
    }
}

@end
