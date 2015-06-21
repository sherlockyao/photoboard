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
    PBTaleInfo* taleInfo = [self.params objectForKey:ParamKeyTaleInfo];
    if (result) {
        result((nil == taleInfo));
    }
}

- (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)())completion {
    [PBDataManager createTaleWithSceneInfos:sceneInfos completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

- (void)deleteTaleOfTaleInfo:(PBTaleInfo *)taleInfo completion:(void(^)())completion {
    [PBTale deleteByObjectId:taleInfo.objectId completion:^(BOOL success, NSError *error) {
        completion();
    }];
}

@end
