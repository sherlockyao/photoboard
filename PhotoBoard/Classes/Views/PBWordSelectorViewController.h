//
//  PBWordSelectorViewController.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/9/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBWordGroupPresenter.h"
#import "PBWordSelectorView.h"

@protocol PBWordSelectorViewControllerDelegate;

@interface PBWordSelectorViewController : UIViewController

@property (nonatomic, strong) PBWordSelectorView* wordSelectorView;

@property (nonatomic, strong) PBWordGroupPresenter* wordGroupPresenter;

@property (nonatomic, weak) id<PBWordSelectorViewControllerDelegate> delegate;

@end


@protocol PBWordSelectorViewControllerDelegate <NSObject>

@optional
- (void)wordSelectorViewController:(PBWordSelectorViewController *)wordSelectorViewController didSelectWord:(PBWord *)word;
- (void)wordSelectorViewControllerDidClickCustomize:(PBWordSelectorViewController *)wordSelectorViewController;

@end
