//
//  PNSceneCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneCell.h"
#import "PBAssetsLibraryUtil.h"

@implementation PBSceneCell

- (void)awakeFromNib {
    self.wordButton.layer.cornerRadius = 20;
    self.wordButton.layer.borderWidth = 1;
    self.wordButton.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)displaySceneInfo:(PBSceneInfo *)sceneInfo {
    self.wordLabel.text = sceneInfo.word ?: @"本来";
    self.noteLabel.text = sceneInfo.note ?: @"...";
    [[PBAssetsLibraryUtil assetsLibrary] assetForURL:sceneInfo.assetURL resultBlock:^(ALAsset *asset) {
        self.photoImageView.image = [[UIImage alloc] initWithCGImage:[asset thumbnail]];
    } failureBlock:nil];
}

#pragma mark - IB Actions

- (IBAction)wordButtonTouchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sceneCellDidClickWordButton:)]) {
        [self.delegate sceneCellDidClickWordButton:self];
    }
}

- (IBAction)noteButtonTouchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sceneCellDidClickNoteButton:)]) {
        [self.delegate sceneCellDidClickNoteButton:self];
    }
}

@end
