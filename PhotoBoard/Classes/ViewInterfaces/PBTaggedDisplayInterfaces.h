//
//  PBTaggedDisplayInterfaces.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/2/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>

// Process HUD

typedef NS_ENUM(NSInteger, PBProcessHUDTag) {
    PBProcessHUDTagSceneGroup,
    PBProcessHUDTagShare
};

@protocol PBProcessHUDInterface <NSObject>

- (void)beginProcess:(PBProcessHUDTag)tag;
- (void)endProcess:(PBProcessHUDTag)tag;

@end
