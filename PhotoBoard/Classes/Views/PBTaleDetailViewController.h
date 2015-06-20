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

@interface PBTaleDetailViewController : UIViewController

@property (nonatomic, strong) PBSceneListView* sceneListView;

@property (nonatomic, strong) PBSceneGroupPresenter* sceneGroupPresenter;

@end
