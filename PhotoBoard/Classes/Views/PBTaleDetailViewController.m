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
@property (nonatomic, assign) NSUInteger currentEditMode; // 0: edit word, 1: edit note

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
    [self loadSceneInfos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

#pragma mark - PBSceneListViewDelegate

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditWordAtRowIndex:(NSUInteger)index {
    self.currentEditIndex = index;
    self.currentEditMode = 0;
    [self startEditingText];
}

- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditNoteAtRowIndex:(NSUInteger)index {
    self.currentEditIndex = index;
    self.currentEditMode = 1;
    [self startEditingText];
}

#pragma mark - Logic

- (void)loadSceneInfos {
    [self.sceneGroupPresenter loadSceneInfos];
}

- (void)startEditingText {
    self.editTextField.text = nil;
    if (0 == self.currentEditMode) {
        self.editTextField.placeholder = @"关联词";
        self.editTextField.textAlignment = NSTextAlignmentCenter;
    } else {
        self.editTextField.placeholder = @"描述";
        self.editTextField.textAlignment = NSTextAlignmentLeft;
    }
    [self.editTextField becomeFirstResponder];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self animateShowEditViewWithKeyboardHeight:size.height];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self animateHideEditView];
}


#pragma mark - IB Actions

- (IBAction)editDoneButtonTouchUpInside:(id)sender {
    NSString* text = self.editTextField.text;
    if (0 == self.currentEditMode) {
        [self.sceneListView displayUpdatedWord:text forRowIndex:self.currentEditIndex];
    } else {
        [self.sceneListView displayUpdatedNote:text forRowIndex:self.currentEditIndex];
    }
    [self.editTextField resignFirstResponder];
}

- (IBAction)editCancelButtonTouchUpInside:(id)sender {
    [self.editTextField resignFirstResponder];
}

#pragma mark - Animations

- (void)animateShowEditViewWithKeyboardHeight:(CGFloat)keyboardHeight {
    if (!self.editView.hidden && self.editViewBottomConstraint.constant == keyboardHeight) {
        return;
    }
    self.editView.hidden = NO;
    self.maskView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.editView.alpha = 1;
        self.maskView.alpha = 0.3;
        self.editViewBottomConstraint.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)animateHideEditView {
    if (self.editView.hidden) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.editView.alpha = 0;
        self.maskView.alpha = 0;
        self.editViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.editView.hidden = YES;
        self.maskView.hidden = YES;
    }];
}

#pragma mark - Configuration

- (void)loadSceneListView {
    self.sceneListView = [[[NSBundle mainBundle] loadNibNamed:@"PBSceneListView" owner:nil options:nil] lastObject];
    self.sceneListView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sceneListView.delegate = self;
    [self.view insertSubview:self.sceneListView belowSubview:self.maskView];
    
    [self.sceneListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    self.sceneGroupPresenter.sceneList = self.sceneListView;
}

- (void)configureProperties {
}

- (void)configureViewComponents {
    
}

@end
