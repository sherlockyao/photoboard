//
//  PNSceneCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneCell.h"

@implementation PBSceneCell

- (void)awakeFromNib {
    self.wordButton.layer.cornerRadius = 20;
    self.wordButton.layer.borderWidth = 1;
    self.wordButton.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)displayScene:(PBScene *)scene {
    self.wordLabel.text = scene.word ?: @"连接词";
    self.noteLabel.text = scene.note ?: @"...";
    [self updateWordLabelForProperFont];
    self.photoImageView.image = [[UIImage alloc] initWithCGImage:[scene.asset thumbnail]];
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

#pragma mark - Layout

- (void)updateWordLabelForProperFont {
    BOOL useBigFont = (3 > [self.wordLabel.text length]);
    self.wordLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:(useBigFont ? 14 : 12)];
}

@end
