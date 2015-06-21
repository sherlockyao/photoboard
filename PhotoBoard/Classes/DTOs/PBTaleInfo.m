//
//  PBTaleInfo.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleInfo.h"
#import "PBSceneInfo.h"

@implementation PBTaleInfo

- (NSURL *)coverAssetURL {
    if (0 == [self.sceneInfos count]) {
        return nil;
    }
    return ((PBSceneInfo *)self.sceneInfos[0]).assetURL;
}

@end
