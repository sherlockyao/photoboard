//
//  PNSceneListView.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneListView.h"
#import "PBSceneCell.h"

static NSString *const SceneCellReuseIdentifier = @"SceneCell";


@interface PBSceneListView () <UITableViewDataSource, UITableViewDelegate, PBSceneCellDelegate>

@property (readwrite, nonatomic, strong) NSArray* sceneInfos;

@end


@implementation PBSceneListView

- (void)awakeFromNib {
    [self configureProperties];
    [self configureViewComponents];
}

- (void)displayUpdatedWord:(NSString *)word forRowIndex:(NSUInteger)index {
    PBSceneInfo* sceneInfo = self.sceneInfos[index];
    sceneInfo.word = word;
    PBSceneCell* cell = (PBSceneCell *)[self.sceneTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell displaySceneInfo:sceneInfo];
}

- (void)displayUpdatedNote:(NSString *)note forRowIndex:(NSUInteger)index {
    PBSceneInfo* sceneInfo = self.sceneInfos[index];
    sceneInfo.note = note;
    PBSceneCell* cell = (PBSceneCell *)[self.sceneTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell displaySceneInfo:sceneInfo];
}

#pragma mark - PBSceneListInterface

- (void)displaySceneInfos:(NSArray *)sceneInfos {
    self.sceneInfos = sceneInfos;
    [self.sceneTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sceneInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBSceneCell* cell = [tableView dequeueReusableCellWithIdentifier:SceneCellReuseIdentifier forIndexPath:indexPath];
    [cell displaySceneInfo:self.sceneInfos[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - PBSceneCellDelegate

- (void)sceneCellDidClickWordButton:(PBSceneCell *)sceneCell {
    NSIndexPath* indexPath = [self.sceneTableView indexPathForCell:sceneCell];
    if ([self.delegate respondsToSelector:@selector(sceneListView:didSelectEditWordAtRowIndex:)]) {
        [self.delegate sceneListView:self didSelectEditWordAtRowIndex:indexPath.row];
    }
}

- (void)sceneCellDidClickNoteButton:(PBSceneCell *)sceneCell {
    NSIndexPath* indexPath = [self.sceneTableView indexPathForCell:sceneCell];
    if ([self.delegate respondsToSelector:@selector(sceneListView:didSelectEditNoteAtRowIndex:)]) {
        [self.delegate sceneListView:self didSelectEditNoteAtRowIndex:indexPath.row];
    }
}

#pragma mark - Configuration

- (void)configureProperties {
    self.sceneInfos = @[];
}

- (void)configureViewComponents {
    // table view
    self.sceneTableView.delegate = self;
    self.sceneTableView.dataSource = self;
    [self.sceneTableView registerNib:[UINib nibWithNibName:@"PBSceneCell" bundle:nil] forCellReuseIdentifier:SceneCellReuseIdentifier];
    self.sceneTableView.rowHeight = 212;
    self.sceneTableView.contentInset = UIEdgeInsetsMake(8, 0, 16, 0);
}
@end
