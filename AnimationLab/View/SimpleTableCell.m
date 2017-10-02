//
//  CityCell.m
//  AnimationLab
//
//  Created by Ahri on 9/3/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

+ (NSString *)cellIdentifier {
    return @"SimpleTableCell";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
