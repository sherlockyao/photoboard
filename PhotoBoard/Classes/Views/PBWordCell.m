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
    self.dotView.layer.borderWidth = 2;
    self.dotView.layer.cornerRadius = 32;
}

- (void)displayWord:(PBWord *)word {
    self.titleLabel.text = word.text;
    if (2 >= [word.text length]) {
        self.titleLabel.font = [UIFont systemFontOfSize:18];
    } else {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    self.dotView.layer.borderColor = word.color.CGColor;
}

@end
