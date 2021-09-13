//
//  MealCategoryCell.h
//  demo-objc
//
//  Created by Ricardo Ruiz on 8/29/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MealCategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

NS_ASSUME_NONNULL_END
