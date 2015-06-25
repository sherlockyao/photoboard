//
//  PBWordSelectorView.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordSelectorView.h"
#import "PBWordCell.h"

static NSString *const WordCellReuseIdentifier = @"WordCell";


@interface PBWordSelectorView () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic, strong) NSArray* words;

@end

@implementation PBWordSelectorView

- (void)awakeFromNib {
    [self configureProperties];
    [self configureViewComponents];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBWordCell* cell = [tableView dequeueReusableCellWithIdentifier:WordCellReuseIdentifier forIndexPath:indexPath];
    [cell displayWord:self.words[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(wordSelectorView:didSelectWord:)]) {
        [self.delegate wordSelectorView:self didSelectWord:self.words[indexPath.row]];
    }
}

#pragma mark - PBWordListInterface

- (void)displayWords:(NSArray *)words {
    self.words = words;
    [self.wordTableView reloadData];
}

#pragma mark - Animations

- (void)animateShowSelectorWithCompletion:(void (^)(void))completion {
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.2;
        self.panelViewBottomConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)animateHideSelectorWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0;
        self.panelViewBottomConstraint.constant = -400;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - IB Actions

- (IBAction)customizeButtonTouchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(wordSelectorViewDidClickCustomize:)]) {
        [self.delegate wordSelectorViewDidClickCustomize:self];
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(wordSelectorViewDidClickCancel:)]) {
        [self.delegate wordSelectorViewDidClickCancel:self];
    }
}

#pragma mark - Configuration

- (void)configureProperties {
    self.words = @[];
}

- (void)configureViewComponents {
    // panel view
    self.panelViewBottomConstraint.constant = -400;
    
    // table view
    self.wordTableView.delegate = self;
    self.wordTableView.dataSource = self;
    [self.wordTableView registerNib:[UINib nibWithNibName:@"PBWordCell" bundle:nil] forCellReuseIdentifier:WordCellReuseIdentifier];
    self.wordTableView.rowHeight = 50;
}


@end
