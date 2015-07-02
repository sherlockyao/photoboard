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

@interface PBSharePresenter ()

@property (nonatomic, strong) PBTaleShareTemplateView* templateView;

@end

@implementation PBSharePresenter

- (void)shareScenes:(NSArray *)scenes from:(UIViewController *)viewController {
    [self.processHUD beginProcess:PBProcessHUDTagShare];
    [self.templateView generateSnapshotForScenes:scenes result:^(UIImage *snapshot) {
        [self.processHUD endProcess:PBProcessHUDTagShare];
        UIActivityViewController* activityViewController = [self activityViewControllerForActivityItems:@[snapshot] thumbnail:nil];
        [viewController presentViewController:activityViewController animated:YES completion:nil];
    }];
}

#pragma mark - Share Methods

- (UIActivityViewController *)activityViewControllerForActivityItems:(NSArray *)activityItems thumbnail:(UIImage *)thumbnail {
    // add wechat activities
    PBWeChatMessageActivity* weChatMessageActivity = [PBWeChatMessageActivity new];
    PBWeChatMomentActivity* weChatMomentActivity = [PBWeChatMomentActivity new];
    weChatMessageActivity.thumbnail = thumbnail;
    weChatMomentActivity.thumbnail = thumbnail;
    
    UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[ weChatMessageActivity, weChatMomentActivity ]];
    activityViewController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll];
    
    return activityViewController;
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
