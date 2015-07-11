//
//  PBTaleDetailViewController.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBSceneListView.h"
#import "PBSceneGroupPresenter.h"
#import "PBTaleMaintainPresenter.h"
#import "PBSharePresenter.h"

@interface PBTaleDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *navigationShadowView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *functionButton;
@property (nonatomic, strong) PBSceneListView* sceneListView;

@property (nonatomic, strong) PBSceneGroupPresenter* sceneGroupPresenter;
@property (nonatomic, strong) PBTaleMaintainPresenter* taleMaintainPresenter;
@property (nonatomic, strong) PBSharePresenter* sharePresenter;

@end
