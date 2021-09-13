//
//  Meals.m
//  demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import "Meals.h"
#import "API.h"
#import "Theme.h"
#import "Constants.h"
#import "MealsCell.h"
#import "MealRecipe.h"
#import "Meal.h"
#import "Recipe.h"

@interface Meals () <UICollectionViewDelegate, UICollectionViewDataSource>

// UI Elements
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *header;

@end

@implementation Meals

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

- (void)drawUI {
    
    kForceDarkMode;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.view.backgroundColor = kColor_flatBlack;
        
        self.header = [Theme drawUI_mealHeader:self.textTitle];
        [self.view addSubview:self.header];
        
        self.collectionView = [Theme drawUI_mealCollectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.view addSubview:self.collectionView];
    });
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

    Meal *target = [self.currentCollection objectAtIndex:indexPath.row];
    MealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kColor_darkGray;
    cell.label.text = [NSString stringWithFormat:@"%@",target.strMeal].capitalizedString;
    cell.imageview.image = nil;
    [API loadImage:target.strMealThumb withHandler:^(UIImage * _Nonnull result) {
        if (result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageview.image = result;
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
    return CGSizeMake(kScreenWidth, 95);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    @try {
        __weak Meals *weakSelf = self;
        Meal *meal = [self.currentCollection objectAtIndex:indexPath.row];
        [API loadMeal:meal.idMeal withHandler:^(NSDictionary * _Nonnull result) {
            MealRecipe *recipe = result[@"recipe"];
            dispatch_async(dispatch_get_main_queue(), ^{
                Recipe *recipeView = [[Recipe alloc]init];
                recipeView.recipe = recipe;
                recipeView.modalPresentationStyle = UIModalPresentationFormSheet;
                [weakSelf presentViewController:recipeView animated:YES completion:nil];
            });
        }];
    } @catch (NSException *exception) {
        NSLog(@"exception: %@",exception);
    }
}


@end
