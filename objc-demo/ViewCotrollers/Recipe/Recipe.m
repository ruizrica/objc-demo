//
//  Recipe.m
//  demo-objc
//
//  Created by Kenetic Labs on 8/30/21.
//

#import "Recipe.h"
#import "API.h"
#import "Theme.h"
#import "Constants.h"

@interface Recipe ()
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) UIView *labels;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *actionButton;
@property (nonatomic,strong) UILabel *action_lb;
@end

@implementation Recipe

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

- (void)drawUI {
    
    kForceDarkMode;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.view.backgroundColor = kColor_flatBlack;
        
        self.header = [Theme drawUI_recipeHeader:self.recipe.strMeal];
        [self.view addSubview:self.header];
        
        self.imageView = [Theme drawUI_recipeImageView];
        [self.view addSubview:self.imageView];
        
        // Background

        [self.view addSubview:[Theme drawUI_recipeContentSection]];
        self.textView = [Theme drawUI_recipeInstructions];
        self.textView.text = self.recipe.strInstructions;
        [self.view addSubview:self.textView];
        
        self.actionButton =  [[UIButton alloc]initWithFrame:CGRectMake(0, 300,kScreenWidth/2-30, 40)];
        [self.actionButton addTarget:self action:@selector(actionButton_task) forControlEvents:UIControlEventTouchUpInside];
        self.actionButton.titleLabel.font = kFont_BoldItalic_WSize(16);
        self.actionButton.titleLabel.textColor = kColor_flatYellow;
        self.actionButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.actionButton.backgroundColor = [kColor_flatBlack colorWithAlphaComponent:0.5];
        [self.actionButton setTitle:@"Ingredients" forState:UIControlStateNormal];
        [self.view addSubview:self.actionButton];
        
        float xOffset = 20;
        float yOffset = 350;
        self.action_lb = [[UILabel alloc]initWithFrame:CGRectMake(xOffset, yOffset, kScreenWidth-xOffset, 40)];
        self.action_lb.font = kFont_BoldItalic_WSize(24);
        self.action_lb.textColor = [UIColor whiteColor];
        self.action_lb.text = @"Instructions";
        [self.view addSubview: self.action_lb];
        
        self.imageView.image = nil;
        [API loadImage:self.recipe.strMealThumb withHandler:^(UIImage * _Nonnull result) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = result;
                });
            } else {
                NSLog(@"Error Loading Image...");
            }
        }];
        
        UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-60,300,60,40)];
        [share setTitle:@"Share" forState:UIControlStateNormal];
        share.titleLabel.font = kFont_BoldItalic_WSize(14);
        [share addTarget:self action:@selector(share_action) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:share];
        
        UIButton *video = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-120,300,60,40)];
        [video setTitle:@"Video" forState:UIControlStateNormal];
        video.titleLabel.font = kFont_BoldItalic_WSize(14);
        [video addTarget:self action:@selector(video_action) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:video];
        
        UIButton *web = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-180,300,60,40)];
        [web setTitle:@"Source" forState:UIControlStateNormal];
        web.titleLabel.font = kFont_BoldItalic_WSize(14);
        [web addTarget:self action:@selector(web_action) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:web];

    });
}

- (void)share_action {
    
    @try {
        NSMutableString *ingredientListString = [[NSMutableString alloc]init];
        for (NSDictionary *ingredient in self.recipe.ingredients) {
            [ingredientListString appendString:[NSString stringWithFormat:@"- %@ %@\n",ingredient.allKeys[0],ingredient.allValues[0]]];
        }
        
        NSArray *sharedObjects = @[self.recipe.strMeal,@" ",@"Instructions: ",self.recipe.strInstructions,@" ",@" ",@"\n\nIngredients: ", ingredientListString.capitalizedString,];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
            activityViewController.popoverPresentationController.sourceView = self.view;
            [self presentViewController:activityViewController animated:YES completion:nil];
        });
    } @catch (NSException *exception) {
        NSLog(@"Error Sharing Recipe... Error: %@",exception);
    }
}

- (void)video_action {
    
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.recipe.strYoutube] options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    kl(video displayed...)
                }
            }];
        });
    } @catch (NSException *exception) {
        NSLog(@"Error Opening Video... Error: %@",exception);
    }
}

- (void)web_action {
    
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.recipe.strSource] options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    kl(webpage displayed...)
                }
            }];
        });
    } @catch (NSException *exception) {
        NSLog(@"Error Opening Webpage... Error: %@",exception);
    }
}

- (void)actionButton_task {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.actionButton.titleLabel.text isEqualToString:@"Ingredients"]) {
            [self.actionButton setTitle:@"Instructions" forState:UIControlStateNormal];
            self.actionButton.backgroundColor = [kColor_flatBlack colorWithAlphaComponent:0.2];
            self.action_lb.text = @"Ingredients";
            self.textView.text = @"";
            
            NSMutableString *ingredientListString = [[NSMutableString alloc]init];
            for (NSDictionary *ingredient in self.recipe.ingredients) {
                [ingredientListString appendString:[NSString stringWithFormat:@"- %@ %@\n",ingredient.allKeys[0],ingredient.allValues[0]]];
            }
            self.textView.text = ingredientListString.capitalizedString;
        } else {
            [self.actionButton setTitle:@"Ingredients" forState:UIControlStateNormal];
            self.actionButton.backgroundColor = [kColor_flatBlack colorWithAlphaComponent:0.5];
            self.action_lb.text = @"Instructions";
            self.textView.text = self.recipe.strInstructions;
        }
    });
}

@end
