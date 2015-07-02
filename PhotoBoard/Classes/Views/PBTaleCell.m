//
//  PBTaleCell.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleCell.h"
#import "PBAssetsLibraryUtil.h"
#import "ALAsset+PBUtil.h"
#import "UIView+Positioning.h"

@interface PBTaleCell ()

@property (nonatomic, strong) CAGradientLayer *photoGradientLayer;
@property (nonatomic, strong) ALAsset* displayedAsset;

@end


@implementation PBTaleCell

- (void)awakeFromNib {
    self.photoGradientLayer = [CAGradientLayer layer];
    self.photoGradientLayer.frame = self.photoImageView.bounds;
    self.photoGradientLayer.colors =  @[(id)[[UIColor colorWithWhite:0.f alpha:0.7f] CGColor], (id)[[UIColor colorWithWhite:0.f alpha:0.f] CGColor]];
    self.photoGradientLayer.startPoint = CGPointMake(0.5f, 1.f);
    self.photoGradientLayer.endPoint = CGPointMake(0.5f, 0.7f);
    [self.photoImageView.layer insertSublayer:self.photoGradientLayer atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect gradientFrame = self.bounds;
    gradientFrame.size.width -= 16;
    gradientFrame.size.height -= 8;
    self.photoGradientLayer.frame = gradientFrame;
}

- (void)displayTale:(PBTale *)tale {
    self.titleLabel.text = [self titleStringFromDate:tale.timestamp];
    if (![[tale coverAssetURL] isEqual:[self.displayedAsset url]]) {
        [[PBAssetsLibraryUtil assetsLibrary] assetForURL:[tale coverAssetURL] resultBlock:^(ALAsset *asset) {
            self.displayedAsset = asset;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSUInteger size = [self.photoImageView width] * [[UIScreen mainScreen] scale];
                UIImage* image = [asset thumbnailForPixelSize:size];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.photoImageView.image = image;
                });
            });
        } failureBlock:nil];
    }
}

#pragma mark - IB Actions

- (IBAction)deleteButtonTouchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(taleCellDidClickDeleteButton:)]) {
        [self.delegate taleCellDidClickDeleteButton:self];
    }
}

#pragma mark - Helper Method

- (NSString *)titleStringFromDate:(NSDate *)date {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM-dd hh:mm"];
    }
    return [dateFormatter stringFromDate:date];
}

@end
