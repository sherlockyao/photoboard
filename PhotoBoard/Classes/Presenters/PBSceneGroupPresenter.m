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

- (void)loadScenes {
    NSArray* scenes = [self.params objectForKey:ParamKeySceneList];
    if (!scenes) {
        PBTale* tale = [self.params objectForKey:ParamKeyTale];
        scenes = tale ? tale.scenes : @[];
    }
    [self.sceneList displayScenes:scenes];
}

@end
