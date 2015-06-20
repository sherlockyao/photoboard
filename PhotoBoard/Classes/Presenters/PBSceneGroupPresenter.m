//
//  PBSceneGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneGroupPresenter.h"
#import "PBConstants.h"

@implementation PBSceneGroupPresenter

- (void)loadSceneInfos {
    NSArray* sceneInfos = [self.params objectForKey:ParamKeySceneInfos];
    if (!sceneInfos) {
        sceneInfos = @[];
    }
    [self.sceneList displaySceneInfos:sceneInfos];
}

@end
