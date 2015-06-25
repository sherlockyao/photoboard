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
    self.dotView.layer.borderWidth = 1;
    self.dotView.layer.cornerRadius = 23;
}

- (void)displayWord:(PBWord *)word {
    self.titleLabel.text = word.text;
    self.dotView.layer.borderColor = word.color.CGColor;
}

@end
