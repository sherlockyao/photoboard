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

- (IBAction)createButtonTouchUpInside:(id)sender {
    [self.taleMaintainPresenter createTaleWithScenes:self.sceneListView.scenes completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)shareButtonTouchUpInside:(id)sender {
    [self.sharePresenter shareScenes:self.sceneListView.scenes from:self];
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
}

- (void)configureProperties {
    [self.taleMaintainPresenter checkMaintainState:^(BOOL isMaintainable) {
        self.isEditable = isMaintainable;
    }];
}

- (void)configureViewComponents {
    // navigation
    if (self.isEditable) {
        UIBarButtonItem* createItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(createButtonTouchUpInside:)];
        self.navigationItem.rightBarButtonItems = @[createItem];
    } else {
        UIBarButtonItem* shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonTouchUpInside:)];
        self.navigationItem.rightBarButtonItems = @[shareItem];
    }
    
    // wire up view interfaces
    self.sceneGroupPresenter.sceneList = self.sceneListView;
    self.sharePresenter.processHUD = self;
    self.sceneGroupPresenter.processHUD = self;
}

@end
