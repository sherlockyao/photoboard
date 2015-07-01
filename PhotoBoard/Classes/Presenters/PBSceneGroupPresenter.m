//
//  PBSceneGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneGroupPresenter.h"
#import "PBAssetsLibraryUtil.h"
#import "PBConstants.h"
#import "PBTale.h"
#import "PBScene.h"
#import "EXTScope.h"

@implementation PBSceneGroupPresenter

- (void)loadScenes {
    NSArray* scenes = [self.params objectForKey:ParamKeySceneList];
    if (!scenes) {
        PBTale* tale = [self.params objectForKey:ParamKeyTale];
        scenes = tale ? tale.scenes : @[];
    }
    @weakify(self)
    [self preloadAssetsForScenes:scenes completion:^(NSArray *scenes) {
        @strongify(self)
        [self.sceneList displayScenes:scenes];
    }];
}

#pragma mark - Private Methods

- (void)preloadAssetsForScenes:(NSArray *)scenes completion:(void(^)(NSArray* scenes))completion {
    dispatch_group_t group = dispatch_group_create();
    for (PBScene* scene in scenes) {
        if (scene.asset) {
            continue;
        }
        dispatch_group_enter(group);
        [[PBAssetsLibraryUtil assetsLibrary] assetForURL:scene.assetURL resultBlock:^(ALAsset *asset) {
            dispatch_group_leave(group);
            scene.asset = asset;
        } failureBlock:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
        completion(scenes);
    });
}

@end
