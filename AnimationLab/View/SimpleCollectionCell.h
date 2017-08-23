//
//  SimpleCollectionCell.h
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

+ (NSString*)cellIdentifier;
+ (NSString*)nibName;

@end
