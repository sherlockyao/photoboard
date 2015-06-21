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

@implementation PBSharePresenter

- (void)shareTaleInfo:(PBTaleInfo *)taleInfo from:(UIViewController *)viewController {
    //TODO: generate image for tale info
    
    UIActivityViewController* activityViewController = [self activityViewControllerForActivityItems:@[] thumbnail:nil];
    [viewController presentViewController:activityViewController animated:YES completion:nil];
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

@end
