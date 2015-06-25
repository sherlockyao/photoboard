//
//  PBWordCell.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBWord.h"

@interface PBWordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *dotView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)displayWord:(PBWord *)word;

@end
