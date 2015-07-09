//
//  PBWordSelectorViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/9/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordSelectorViewController.h"
#import "Masonry.h"

@interface PBWordSelectorViewController () <PBWordSelectorViewDelegate>

@end

@implementation PBWordSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add other views
    [self loadWordSelectorView];
    // configure
    [self configureViewComponents];
    // load data
    [self.wordGroupPresenter loadWords];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.wordSelectorView animateShowSelectorWithCompletion:nil];
}

#pragma mark - PBWordSelectorViewDelegate

- (void)wordSelectorView:(PBWordSelectorView *)wordSelectorView didSelectWord:(PBWord *)word {
    if ([self.delegate respondsToSelector:@selector(wordSelectorViewController:didSelectWord:)]) {
        [self.delegate wordSelectorViewController:self didSelectWord:word];
    }
    [self.wordSelectorView animateHideSelectorWithCompletion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)wordSelectorViewDidClickCustomize:(PBWordSelectorView *)wordSelectorView {
    if ([self.delegate respondsToSelector:@selector(wordSelectorViewControllerDidClickCustomize:)]) {
        [self.delegate wordSelectorViewControllerDidClickCustomize:self];
    }
    [self.wordSelectorView animateHideSelectorWithCompletion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)wordSelectorViewDidClickCancel:(PBWordSelectorView *)wordSelectorView {
    [self.wordSelectorView animateHideSelectorWithCompletion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - Configuration

- (void)loadWordSelectorView {
    self.wordSelectorView = [[[NSBundle mainBundle] loadNibNamed:@"PBWordSelectorView" owner:nil options:nil] lastObject];
    self.wordSelectorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.wordSelectorView.delegate = self;
    [self.view addSubview:self.wordSelectorView];
    
    [self.wordSelectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)configureViewComponents {
    // wire up view interfaces
    self.wordGroupPresenter.wordList = self.wordSelectorView;
}

@end
