//
//  PBWeChatMessageActivity.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWeChatMessageActivity.h"
#import "WXApi.h"

NSString *const PBActivityTypeWeChatMessage = @"PBActivityTypeWeChatMessage";

@implementation PBWeChatMessageActivity

- (NSString *)activityType {
    return PBActivityTypeWeChatMessage;
}

- (int)scene {
    return WXSceneSession;
}

- (NSString *)activityTitle {
    return @"微信";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"wechat_share_message"];
}

@end
