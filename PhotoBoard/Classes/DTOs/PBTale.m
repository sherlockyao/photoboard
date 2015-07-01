//
//  PBTaleInfo.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTale.h"
#import "PBScene.h"

@implementation PBTale

- (NSURL *)coverAssetURL {
    if (0 == [self.scenes count]) {
        return nil;
    }
    return ((PBScene *)self.scenes[0]).assetURL;
}

@end
