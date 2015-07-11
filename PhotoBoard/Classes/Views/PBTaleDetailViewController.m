//
//  PBTaleDetailViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleDetailViewController.h"
#import "PBWordSelectorViewController.h"
#import "PBDescriptionEditorViewController.h"
#import "UIBarButtonItem+PBUtil.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "PBWireframe.h"
#import "PBConstants.h"

@interface PBTaleDetailViewController () <PBSceneListViewDelegate, PBProcessHUDInterface, PBWordSelectorViewControllerDelegate, PBDescriptionEditorViewControllerDelegate>

@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic, assign) NSInteger currentEditIndex;
@property (nonatomic, assign) NSString* currentEditText;

@end

@implementation PBTaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add other views
    [self loadSceneListView];
    // configure
    [self configureProperties];
    [self configureViewComponents];
    // load data
    [self loadDisplayingData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - PBSceneListViewDelegate

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditWord:(NSString *)word atRowIndex:(NSInteger)index{
    if (self.isEditable) {
        self.currentEditIndex = index;
        self.currentEditText = word;
        [PBWireframe presentWordSelectorViewControllerFrom:self];
    }
}

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditNote:(NSString *)note atRowIndex:(NSInteger)index {
    if (self.isEditable) {
        self.currentEditIndex = index;
        self.currentEditText = note;
        [self presentEditorForEditNote];
    }
}

- (void)sceneListView:(PBSceneListView *)sceneListView didToggleTopOffScreenState:(BOOL)isScrollOffTop {
    self.navigationShadowView.hidden = !isScrollOffTop;
}

#pragma mark - PBWordSelectorViewControllerDelegate

- (void)wordSelectorViewController:(PBWordSelectorViewController *)wordSelectorViewController didSelectWord:(PBWord *)word {
    [self.sceneListView displayUpdatedWord:word.text forRowIndex:self.currentEditIndex];
}

- (void)wordSelectorViewControllerDidClickCustomize:(PBWordSelectorViewController *)wordSelectorViewController {
     [self presentEditorForEditWord];
}

#pragma mark - PBDescriptionEditorViewControllerDelegate

- (void)descriptionEditorViewController:(PBDescriptionEditorViewController *)descriptionEditorViewController didSubmitWord:(NSString *)word {
    [self.sceneListView displayUpdatedWord:word forRowIndex:self.currentEditIndex];
}

- (void)descriptionEditorViewController:(PBDescriptionEditorViewController *)descriptionEditorViewController didSubmitNote:(NSString *)note {
    [self.sceneListView displayUpdatedNote:note forRowIndex:self.currentEditIndex];
}

#pragma mark - PBProcessHUDInterface

- (void)beginProcess:(PBProcessHUDTag)tag {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)endProcess:(PBProcessHUDTag)tag {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Logic

- (void)loadDisplayingData {
    [self.sceneGroupPresenter loadScenes];
}

- (void)presentEditorForEditWord {
    NSDictionary* params = @{
                             PBParamKeyText : self.currentEditText ?: @"",
                             PBParamKeyType : @(PBDescriptionEditorTypeWord)
                             };
    [PBWireframe presentDescriptionEditorViewControllerFrom:self withParams:params];
}

- (void)presentEditorForEditNote {
    NSDictionary* params = @{
                             PBParamKeyText : self.currentEditText ?: @"",
                             PBParamKeyType : @(PBDescriptionEditorTypeNote)
                             };
    [PBWireframe presentDescriptionEditorViewControllerFrom:self withParams:params];
}

#pragma mark - IB Actions

- (IBAction)backButtonTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)functionButtonTouchUpInside:(id)sender {
    if (self.isEditable) {
        [self.taleMaintainPresenter createTaleWithScenes:self.sceneListView.scenes completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
       [self.sharePresenter shareScenes:self.sceneListView.scenes from:self];
    }
}

#pragma mark - Configuration

- (void)loadSceneListView {
    self.sceneListView = [[[NSBundle mainBundle] loadNibNamed:@"PBSceneListView" owner:nil options:nil] lastObject];
    self.sceneListView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sceneListView.delegate = self;
    [self.view insertSubview:self.sceneListView belowSubview:self.navigationShadowView];
    
    [self.sceneListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)configureProperties {
    [self.taleMaintainPresenter checkMaintainState:^(BOOL isMaintainable) {
        self.isEditable = isMaintainable;
    }];
}

- (void)configureViewComponents {
    // navigation
    if (self.isEditable) {
        [self.functionButton setTitle:@"创建" forState:UIControlStateNormal];
    } else {
        [self.functionButton setTitle:@"分享" forState:UIControlStateNormal];
    }
    self.navigationShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationShadowView.layer.shadowOffset = CGSizeMake(0, 1);
    self.navigationShadowView.layer.shadowRadius = 2;
    self.navigationShadowView.layer.shadowOpacity = 0.26f;
    self.navigationShadowView.hidden = YES;
    
    // wire up view interfaces
    self.sceneGroupPresenter.sceneList = self.sceneListView;
    self.sharePresenter.processHUD = self;
    self.sceneGroupPresenter.processHUD = self;
}

@end
