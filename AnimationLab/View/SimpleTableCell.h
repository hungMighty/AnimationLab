//
//  CityCell.h
//  AnimationLab
//
//  Created by Ahri on 9/3/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

+ (NSString *)cellIdentifier;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
