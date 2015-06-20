//
//  PBTaleDetailViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleDetailViewController.h"
#import "Masonry.h"

@interface PBTaleDetailViewController () <PBSceneListViewDelegate>

@property (nonatomic, assign) NSUInteger currentEditIndex;

@end

@implementation PBTaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSceneListView];
    [self loadSceneInfos];
}

#pragma mark - PBSceneListViewDelegate

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditWordAtRowIndex:(NSUInteger)index {
    self.currentEditIndex = index;
    //TODO: show edit panel
}

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditNoteAtRowIndex:(NSUInteger)index {
    self.currentEditIndex = index;
    //TODO: show edit panel
}

#pragma mark - Logic

- (void)loadSceneInfos {
    [self.sceneGroupPresenter loadSceneInfos];
}

#pragma mark - Configuration

- (void)loadSceneListView {
    self.sceneListView = [[[NSBundle mainBundle] loadNibNamed:@"PBSceneListView" owner:nil options:nil] lastObject];
    self.sceneListView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sceneListView.delegate = self;
    [self.view addSubview:self.sceneListView];
    
    [self.sceneListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    self.sceneGroupPresenter.sceneList = self.sceneListView;
}

@end
