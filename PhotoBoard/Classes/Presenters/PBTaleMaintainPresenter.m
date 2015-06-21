//
//  PBTaleMaintainPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleMaintainPresenter.h"
#import "PBDataManager.h"

@implementation PBTaleMaintainPresenter

- (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)())completion {
    [PBDataManager createTaleWithSceneInfos:sceneInfos completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

@end