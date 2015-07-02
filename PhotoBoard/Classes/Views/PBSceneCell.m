//
//  PNSceneCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneCell.h"

static CGFloat const PhotoHorizontalPadding = 16;

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
    [self updatePhotoImageViewSizeToFit:[[scene.asset defaultRepresentation] dimensions]];
    self.photoImageView.image = [[UIImage alloc] initWithCGImage:[[scene.asset defaultRepresentation] fullScreenImage]];
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

- (void)updatePhotoImageViewSizeToFit:(CGSize)size {
    static CGFloat totalWidth = 0;
    if (0 == totalWidth) {
        totalWidth = [[UIScreen mainScreen] bounds].size.width - PhotoHorizontalPadding;
    }
    CGFloat photoWidth = 0;
    if (size.height > size.width) {
        // portrait layout
        photoWidth = totalWidth * 4 / 5;
    } else {
        // landscape layout
        photoWidth = totalWidth;
    }
    self.photoImageViewWidthConstraint.constant = photoWidth;
    self.photoImageViewHeightConstraint.constant = floor(photoWidth * size.height / size.width);
}

@end
