//
//  HorizontalTableViewCell.m
//  AnimationLab
//
//  Created by Ahri on 10/8/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "HorizontalTableViewCell.h"

@implementation HorizontalTableViewCell

+ (NSString *)cellIdentifier {
    return @"HorizontalTableViewCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
