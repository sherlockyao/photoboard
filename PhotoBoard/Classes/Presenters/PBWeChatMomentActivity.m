//
//  PBWeChatMomentActivity.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWeChatMomentActivity.h"
#import "WXApi.h"

NSString *const PBActivityTypeWeChatMoment = @"PBActivityTypeWeChatMoment";

@implementation PBWeChatMomentActivity

- (NSString *)activityType {
    return PBActivityTypeWeChatMoment;
}

- (int)scene {
    return WXSceneTimeline;
}

- (NSString *)activityTitle {
    return @"朋友圈";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"wechat_share_moment"];
}

@end
