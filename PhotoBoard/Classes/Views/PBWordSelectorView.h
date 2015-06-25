//
//  PBWordSelectorView.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBWord.h"
#import "PBWordListInterface.h"

@protocol PBWordSelectorViewDelegate;

@interface PBWordSelectorView : UIView <PBWordListInterface>

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITableView *wordTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *panelViewBottomConstraint;

@property (nonatomic, weak) id<PBWordSelectorViewDelegate> delegate;

- (void)animateShowSelectorWithCompletion:(void (^)(void))completion;
- (void)animateHideSelectorWithCompletion:(void (^)(void))completion;

@end


@protocol PBWordSelectorViewDelegate <NSObject>

@optional
- (void)wordSelectorView:(PBWordSelectorView *)wordSelectorView didSelectWord:(PBWord *)word;
- (void)wordSelectorViewDidClickCustomize:(PBWordSelectorView *)wordSelectorView;
- (void)wordSelectorViewDidClickCancel:(PBWordSelectorView *)wordSelectorView;

@end
