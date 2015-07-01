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
    PBTale* tale = [self.params objectForKey:ParamKeyTale];
    if (result) {
        result((nil == tale));
    }
}

- (void)createTaleWithScenes:(NSArray *)scenes completion:(void(^)())completion {
    [PBDataManager createTaleModelWithScenes:scenes completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

- (void)deleteTale:(PBTale *)tale completion:(void(^)())completion {
    [PBTaleModel deleteByObjectId:tale.objectId completion:^(BOOL success, NSError *error) {
        completion();
    }];
}

@end
