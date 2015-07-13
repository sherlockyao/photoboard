//
//  PBSharePresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSharePresenter.h"
#import "PBWeChatMessageActivity.h"
#import "PBWeChatMomentActivity.h"
#import "PBTaleShareTemplateView.h"
#import "PBWireframe.h"

@interface PBSharePresenter ()

@property (nonatomic, strong) PBTaleShareTemplateView* templateView;

@end

@implementation PBSharePresenter

- (void)shareScenes:(NSArray *)scenes from:(UIViewController *)viewController {
    [self.processHUD beginProcess:PBProcessHUDTagShare];
    [self.templateView generateSnapshotForScenes:scenes result:^(UIImage *snapshot) {
        [self.processHUD endProcess:PBProcessHUDTagShare];
        NSDictionary* params = [self shareParamsForActivityItems:@[snapshot] thumbnail:nil];
        [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortShare withParams:params from:viewController];
    }];
}

#pragma mark - Share Methods

- (NSDictionary *)shareParamsForActivityItems:(NSArray *)activityItems thumbnail:(UIImage *)thumbnail {
    // add wechat activities
    PBWeChatMessageActivity* weChatMessageActivity = [PBWeChatMessageActivity new];
    PBWeChatMomentActivity* weChatMomentActivity = [PBWeChatMomentActivity new];
    weChatMessageActivity.thumbnail = thumbnail;
    weChatMomentActivity.thumbnail = thumbnail;
    
    return @{
             @"activityItems" : activityItems,
             @"applicationActivities" : @[ weChatMessageActivity, weChatMomentActivity ]
             };
}

#pragma mark - Getts & Setts

- (PBTaleShareTemplateView *)templateView {
    if (!_templateView) {
        _templateView = [[[NSBundle mainBundle] loadNibNamed:@"PBTaleShareTemplateView" owner:nil options:nil] lastObject];
        _templateView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _templateView;
}

@end
