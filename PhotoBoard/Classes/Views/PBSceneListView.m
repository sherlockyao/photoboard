//
//  PNSceneListView.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneListView.h"
#import "PBSceneCell.h"
#import "UIScreen+PBUtil.h"

static NSString *const SceneCellReuseIdentifier = @"SceneCell";


@interface PBSceneListView () <UITableViewDataSource, UITableViewDelegate, PBSceneCellDelegate>

@property (readwrite, nonatomic, strong) NSArray* scenes;
@property (nonatomic, assign) BOOL isScrollOffTop;

@end


@implementation PBSceneListView

- (void)awakeFromNib {
    [self configureProperties];
    [self configureViewComponents];
}

- (void)displayUpdatedWord:(NSString *)word forRowIndex:(NSUInteger)index {
    PBScene* scene = self.scenes[index];
    scene.word = word;
    PBSceneCell* cell = (PBSceneCell *)[self.sceneTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell displayScene:scene isFirstScene:(0 == index)];
}

- (void)displayUpdatedNote:(NSString *)note forRowIndex:(NSUInteger)index {
    PBScene* scene = self.scenes[index];
    scene.note = note;
    [self.sceneTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)preferredHeigh {
    // create cell instance
    static PBSceneCell* sceneCell = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken,^{
        sceneCell = [self.sceneTableView dequeueReusableCellWithIdentifier:SceneCellReuseIdentifier];
        CGRect bounds = sceneCell.bounds;
        bounds.size.width = [UIScreen screenWidth];
        sceneCell.bounds = bounds;
    });
    // calculate
    __block CGFloat contentHeight = 0;
    [self.scenes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PBScene* scene = obj;
        CGFloat preferredHeight = [sceneCell preferredHeightForScene:scene isFirstScene:(0 == idx)];
        contentHeight += preferredHeight;
    }];
    CGFloat verticalPadding = self.sceneTableView.contentInset.top + self.sceneTableView.contentInset.bottom;
    return  verticalPadding + contentHeight;
}

#pragma mark - PBSceneListInterface

- (void)displayScenes:(NSArray *)scenes {
    self.scenes = scenes;
    [self.sceneTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.scenes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBSceneCell* cell = [tableView dequeueReusableCellWithIdentifier:SceneCellReuseIdentifier forIndexPath:indexPath];
    [cell displayScene:self.scenes[indexPath.row] isFirstScene:(0 == indexPath.row)];
    cell.delegate = self;
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL isScrollOffTop = (self.sceneTableView.contentInset.top < scrollView.contentOffset.y);
    if (self.isScrollOffTop != isScrollOffTop) {
        self.isScrollOffTop = isScrollOffTop;
        if ([self.delegate respondsToSelector:@selector(sceneListView:didToggleTopOffScreenState:)]) {
            [self.delegate sceneListView:self didToggleTopOffScreenState:self.isScrollOffTop];
        }
    }
}

#pragma mark - PBSceneCellDelegate

- (void)sceneCellDidClickWordButton:(PBSceneCell *)sceneCell {
    NSInteger index = [self.sceneTableView indexPathForCell:sceneCell].row;
    PBScene* scene = self.scenes[index];
    if ([self.delegate respondsToSelector:@selector(sceneListView:didSelectEditWord:atRowIndex:)]) {
        [self.delegate sceneListView:self didSelectEditWord:scene.word atRowIndex:index];
    }
}

- (void)sceneCellDidClickNoteButton:(PBSceneCell *)sceneCell {
    NSInteger index = [self.sceneTableView indexPathForCell:sceneCell].row;
    PBScene* scene = self.scenes[index];
    if ([self.delegate respondsToSelector:@selector(sceneListView:didSelectEditNote:atRowIndex:)]) {
        [self.delegate sceneListView:self didSelectEditNote:scene.note atRowIndex:index];
    }
}

#pragma mark - Configuration

- (void)configureProperties {
    self.scenes = @[];
    self.isScrollOffTop = NO;
}

- (void)configureViewComponents {
    // table view
    self.sceneTableView.delegate = self;
    self.sceneTableView.dataSource = self;
    [self.sceneTableView registerNib:[UINib nibWithNibName:@"PBSceneCell" bundle:nil] forCellReuseIdentifier:SceneCellReuseIdentifier];
    self.sceneTableView.estimatedRowHeight = 212;
    self.sceneTableView.rowHeight = UITableViewAutomaticDimension;
    self.sceneTableView.contentInset = UIEdgeInsetsMake(10, 0, 16, 0);
}

@end
