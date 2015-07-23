//
//  PNSceneCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneCell.h"
#import "PBWord.h"
#import "UIView+Positioning.h"

static CGFloat const PhotoHorizontalPadding = 16;

@interface PBSceneCell ()

@property (nonatomic, strong) ALAsset* displayedAsset;

@end

@implementation PBSceneCell

- (void)awakeFromNib {
    self.wordButton.layer.cornerRadius = 32;
    self.wordButton.layer.borderWidth = 1;
    self.wordButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.wordButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.wordButton.layer.shadowOffset = CGSizeMake(0, 1.5f);
    self.wordButton.layer.shadowRadius = 2.0f;
    self.wordButton.layer.shadowOpacity = 0.4f;
}

- (void)displayScene:(PBScene *)scene isFirstScene:(BOOL)isFirstScene {
    // fix layout
    self.topStickView.hidden = isFirstScene;
    self.topStickViewHeightConstraint.constant = isFirstScene ? 20 : 56;
    
    // display text content
    self.wordLabel.text = scene.word ?: @"关联词";
    self.noteLabel.text = scene.note ?: @"...";
    if (scene.word) {
        self.wordLabel.textColor = [UIColor whiteColor];
        self.wordButton.backgroundColor = [PBWord colorForText:scene.word];
        self.wordButton.layer.borderWidth = 0;
    } else {
        self.wordLabel.textColor = [UIColor blackColor];
        self.wordButton.backgroundColor = [UIColor whiteColor];
        self.wordButton.layer.borderWidth = 1;
    }
    [self updateWordLabelForProperFont];
    
    // display asset
    if (![scene.asset isEqual:self.displayedAsset]) {
        self.displayedAsset = scene.asset;
        [self updateImageViewSizeToFitPhotoSize:[[scene.asset defaultRepresentation] dimensions]];
        self.photoImageView.image = [[UIImage alloc] initWithCGImage:[[scene.asset defaultRepresentation] fullScreenImage]];
    }
}

- (CGFloat)preferredHeightForScene:(PBScene *)scene isFirstScene:(BOOL)isFirstScene {
    CGSize photoSize = [[scene.asset defaultRepresentation] dimensions];
    CGSize imageViewSize = [self preferredImageViewSizeForPhotoSize:photoSize];
    CGFloat textAdjustHeight = 0;
    if (scene.note) {
        textAdjustHeight = [scene.note boundingRectWithSize:CGSizeMake(self.noteLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.noteLabel.font } context:nil].size.height - self.noteLabel.height;
    }
    self.topStickViewHeightConstraint.constant = isFirstScene ? 20 : 56;
    [self layoutIfNeeded];
    return self.photoImageView.y + imageViewSize.height + (0 < textAdjustHeight ? textAdjustHeight : 0) + 1; // add 1 for row separator height
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
    if (3 > [self.wordLabel.text length]) {
        self.wordLabel.font = [UIFont systemFontOfSize:18];
    } else {
        self.wordLabel.font = [UIFont systemFontOfSize:16];
    }
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
    CGFloat imageViewWidth = totalWidth;
    CGFloat imageViewHeight = floor(imageViewWidth * photoSize.height / photoSize.width);
    return CGSizeMake(imageViewWidth, imageViewHeight);
}

@end
