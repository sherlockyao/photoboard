//
//  PBTaleMaintainPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleMaintainPresenter.h"
#import "PBConstants.h"
#import "PBDataManager.h"
#import "PBTale+DataManager.h"

@implementation PBTaleMaintainPresenter

- (void)checkMaintainState:(void(^)(BOOL isMaintainable))result {
    PBTale* taleInfo = [self.params objectForKey:ParamKeyTaleInfo];
    if (result) {
        result((nil == taleInfo));
    }
}

- (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)())completion {
    [PBDataManager createTaleModelWithScenes:sceneInfos completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

- (void)deleteTaleOfTaleInfo:(PBTale *)taleInfo completion:(void(^)())completion {
    [PBTaleModel deleteByObjectId:taleInfo.objectId completion:^(BOOL success, NSError *error) {
        completion();
    }];
}

@end
