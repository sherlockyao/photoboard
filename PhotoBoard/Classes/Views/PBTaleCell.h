//
//  PBTaleCell.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTaleInfo.h"

@protocol PBTaleCellDelegate;

@interface PBTaleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, weak) id<PBTaleCellDelegate> delegate;

- (void)displayTaleInfo:(PBTaleInfo *)taleInfo;

@end


@protocol PBTaleCellDelegate <NSObject>

@optional
- (void)taleCellDidClickDeleteButton:(PBTaleCell *)taleCell;

@end
