//
//  ViewController.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTaleGroupPresenter.h"
#import "PBTaleMaintainPresenter.h"

@interface PBTaleListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *taleTableView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@property (nonatomic, strong) PBTaleGroupPresenter* taleGroupPresenter;
@property (nonatomic, strong) PBTaleMaintainPresenter* taleMaintainPresenter;

@end

