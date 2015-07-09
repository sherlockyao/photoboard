//
//  PBWordSelectorView.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordSelectorView.h"
#import "PBWordCell.h"
#import "UIScreen+PBUtil.h"

static NSString *const WordCellReuseIdentifier = @"WordCell";


@interface PBWordSelectorView () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic, strong) NSArray* sectionedWords;
@property (nonatomic, assign) CGFloat panelHeight;

@end

@implementation PBWordSelectorView

- (void)awakeFromNib {
    [self configureProperties];
    [self configureViewComponents];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionedWords[section] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBWord* word = self.sectionedWords[indexPath.section][indexPath.row];
    PBWordCell* cell = [tableView dequeueReusableCellWithIdentifier:WordCellReuseIdentifier forIndexPath:indexPath];
    [cell displayWord:word];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(wordSelectorView:didSelectWord:)]) {
        PBWord* word = self.sectionedWords[indexPath.section][indexPath.row];
        [self.delegate wordSelectorView:self didSelectWord:word];
    }
}

#pragma mark - PBWordListInterface

- (void)displayWords:(NSArray *)words {
    self.sectionedWords = [self localizedSectionedArrayForWords:words];
    [self.wordTableView reloadData];
}

#pragma mark - Animations

- (void)animateShowSelectorWithCompletion:(void (^)(void))completion {
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.17 animations:^{
        self.maskView.alpha = 0.54;
        self.panelViewBottomConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)animateHideSelectorWithCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:0.17 animations:^{
        self.maskView.alpha = 0;
        self.panelViewBottomConstraint.constant = -self.panelHeight;
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

#pragma mark - Gesture Actions

- (void)singleTapMaskViewGestureAction:(UITapGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(wordSelectorViewDidClickCancel:)]) {
        [self.delegate wordSelectorViewDidClickCancel:self];
    }
}

#pragma mark - Helper Methods

- (NSArray *)localizedSectionedArrayForWords:(NSArray *)words {
    UILocalizedIndexedCollation* collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger sectionCount = [[collation sectionTitles] count];
    NSMutableArray* sections = [NSMutableArray arrayWithCapacity:sectionCount];
    // init
    for (NSInteger i = 0; i < sectionCount; i++) {
        [sections addObject:[NSMutableArray array]];
    }
    // add word
    for (PBWord* word in words) {
        NSInteger index = [collation sectionForObject:word collationStringSelector:@selector(text)];
        [sections[index] addObject:word];
    }
    // sort
    for (NSInteger i = 0; i < sectionCount; i++) {
        NSArray* sortedWords = [collation sortedArrayFromArray:sections[i] collationStringSelector:@selector(text)];
        [sections replaceObjectAtIndex:i withObject:sortedWords];
    }
    return sections;
}

#pragma mark - Configuration

- (void)configureProperties {
    self.panelHeight = 470;
    if ([UIScreen is3_5InchScreen]) {
        self.panelHeight = 400;
    } else if ([UIScreen is4InchScreen]) {
        self.panelHeight = 470;
    } else if ([UIScreen is4_7InchScreen]) {
        self.panelHeight = 520;
    } else {
        self.panelHeight = 580;
    }
    self.sectionedWords = [self localizedSectionedArrayForWords:@[]];
}

- (void)configureViewComponents {
    // panel view
    self.panelViewHeightConstraint.constant = self.panelHeight;
    self.panelViewBottomConstraint.constant = -self.panelHeight;
    
    // table view
    self.wordTableView.delegate = self;
    self.wordTableView.dataSource = self;
    [self.wordTableView registerNib:[UINib nibWithNibName:@"PBWordCell" bundle:nil] forCellReuseIdentifier:WordCellReuseIdentifier];
    self.wordTableView.rowHeight = 88;
    self.wordTableView.contentInset = UIEdgeInsetsMake(12, 0, 12, 0);
    
    // mask view
    UITapGestureRecognizer *tapMaskViewRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapMaskViewGestureAction:)];
    [self.maskView addGestureRecognizer:tapMaskViewRecognizer];
}


@end
