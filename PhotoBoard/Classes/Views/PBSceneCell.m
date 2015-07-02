//
//  PNSceneCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneCell.h"
#import "UIView+Positioning.h"

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
    [self updateImageViewSizeToFitPhotoSize:[[scene.asset defaultRepresentation] dimensions]];
    self.photoImageView.image = [[UIImage alloc] initWithCGImage:[[scene.asset defaultRepresentation] fullScreenImage]];
}

- (CGFloat)preferredHeightForScene:(PBScene *)scene {
    CGSize photoSize = [[scene.asset defaultRepresentation] dimensions];
    CGSize imageViewSize = [self preferredImageViewSizeForPhotoSize:photoSize];
    return self.photoImageView.y + imageViewSize.height + 1; // add 1 for row separator height
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

- (void)updateImageViewSizeToFitPhotoSize:(CGSize)photoSize {
    CGSize imageViewSize = [self preferredImageViewSizeForPhotoSize:photoSize];
    self.photoImageViewWidthConstraint.constant = imageViewSize.width;
    self.photoImageViewHeightConstraint.constant = imageViewSize.height;
}

#pragma mark - Calculation

- (CGSize)preferredImageViewSizeForPhotoSize:(CGSize)photoSize {
    static CGFloat totalWidth = 0;
    if (0 == totalWidth) {
        totalWidth = [[UIScreen mainScreen] bounds].size.width - PhotoHorizontalPadding;
    }
    CGFloat imageViewWidth = 0;
    if (photoSize.height > photoSize.width) {
        // portrait layout
        imageViewWidth = totalWidth * 4 / 5;
    } else {
        // landscape layout
        imageViewWidth = totalWidth;
    }
    CGFloat imageViewHeight = floor(imageViewWidth * photoSize.height / photoSize.width);
    return CGSizeMake(imageViewWidth, imageViewHeight);
}

@end
