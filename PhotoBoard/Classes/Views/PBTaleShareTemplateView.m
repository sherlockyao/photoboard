//
//  PBTaleShareTemplateView.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/24/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleShareTemplateView.h"
#import "PBSceneListView.h"
#import "Masonry.h"

@interface PBTaleShareTemplateView ()

@property (nonatomic, strong) PBSceneListView* sceneListView;

@end

@implementation PBTaleShareTemplateView

- (void)awakeFromNib {
    [self loadSceneListView];
    [self configureProperties];
    [self configureViewComponents];
}

- (void)generateSnapshotForScenes:(NSArray *)scenes result:(void(^)(UIImage* snapshot))result {
    [self.sceneListView displayScenes:scenes];
    [self updateLayoutToProperSize];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (result) {
            result([self snapshotTemplateView]);
        }
    });
}

#pragma mark - 

- (void)updateLayoutToProperSize {
    CGRect frame = self.frame;
    frame.size.height = [self.sceneListView preferredHeigh];
    self.frame = frame;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Snapshot

- (UIImage *)snapshotTemplateView {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Configuration

- (void)configureProperties {
    self.frame = [[UIScreen mainScreen] bounds];
}

- (void)configureViewComponents {
}

- (void)loadSceneListView {
    self.sceneListView = [[[NSBundle mainBundle] loadNibNamed:@"PBSceneListView" owner:nil options:nil] lastObject];
    self.sceneListView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.sceneListView];
    
    [self.sceneListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

@end
