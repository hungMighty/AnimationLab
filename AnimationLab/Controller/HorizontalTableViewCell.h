//
//  HorizontalTableViewCell.h
//  AnimationLab
//
//  Created by Ahri on 10/8/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

+ (NSString *)cellIdentifier;

@end
