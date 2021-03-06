//
//  PNSceneCell.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBScene.h"

@protocol PBSceneCellDelegate;

@interface PBSceneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *topStickView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIButton *wordButton;
@property (weak, nonatomic) IBOutlet UIButton *noteButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStickViewHeightConstraint;

@property (nonatomic, weak) id<PBSceneCellDelegate> delegate;

- (void)displayScene:(PBScene *)scene isFirstScene:(BOOL)isFirstScene;
- (CGFloat)preferredHeightForScene:(PBScene *)scene isFirstScene:(BOOL)isFirstScene;

@end


@protocol PBSceneCellDelegate <NSObject>

@optional
- (void)sceneCellDidClickWordButton:(PBSceneCell *)sceneCell;
- (void)sceneCellDidClickNoteButton:(PBSceneCell *)sceneCell;

@end
