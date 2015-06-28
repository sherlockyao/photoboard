//
//  PBWeChatActivity.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWeChatActivity.h"
#import "WXApi.h"

@interface PBWeChatActivity ()

@property (nonatomic, strong) UIImage* image;

@end

@implementation PBWeChatActivity

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryShare;
}

- (int)scene {
    return WXSceneSession;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (![WXApi isWXAppInstalled]) {
        return NO;
    }
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            self.image = activityItem;
            return;
        }
    }
}

- (void)performActivity {
    [self sendImageMessage];
    [self activityDidFinish:YES];
}

#pragma mark - Private Methods

- (void)sendImageMessage {
    WXMediaMessage *message = [WXMediaMessage message];
    // thumbnail
    if (self.thumbnail) {
        [message setThumbImage:self.thumbnail];
    }
    // image data
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(self.image, 0.3);
    message.mediaObject = imageObject;
    // send request
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = [self scene];
    [WXApi sendReq:req];
}

@end
