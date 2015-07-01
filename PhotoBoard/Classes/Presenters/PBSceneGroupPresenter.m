//
//  PBSceneGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneGroupPresenter.h"
#import "PBConstants.h"
#import "PBTale.h"

@implementation PBSceneGroupPresenter

- (void)loadSceneInfos {
    NSArray* scenes = [self.params objectForKey:ParamKeySceneInfos];
    if (!scenes) {
        PBTale* tale = [self.params objectForKey:ParamKeyTaleInfo];
        scenes = tale ? tale.scenes : @[];
    }
    [self.sceneList displayScenes:scenes];
}

@end
