//
//  PBWordCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordCell.h"

@implementation PBWordCell

- (void)awakeFromNib {
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 23;
}

- (void)displayWord:(PBWord *)word {
    self.titleLabel.text = word.text;
    self.layer.borderColor = word.color.CGColor;
}

@end
