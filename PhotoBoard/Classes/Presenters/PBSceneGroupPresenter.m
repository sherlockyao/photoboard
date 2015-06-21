//
//  PBSceneGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneGroupPresenter.h"
#import "PBConstants.h"
#import "PBTaleInfo.h"

@implementation PBSceneGroupPresenter

- (void)loadSceneInfos {
    NSArray* sceneInfos = [self.params objectForKey:ParamKeySceneInfos];
    if (!sceneInfos) {
        PBTaleInfo* taleInfo = [self.params objectForKey:ParamKeyTaleInfo];
        sceneInfos = taleInfo ? taleInfo.sceneInfos : @[];
    }
    [self.sceneList displaySceneInfos:sceneInfos];
}

@end
