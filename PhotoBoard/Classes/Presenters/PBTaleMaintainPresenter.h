//
//  PBTaleMaintainPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBTaleInfo.h"

@interface PBTaleMaintainPresenter : NSObject

@property (nonatomic, strong) NSDictionary* params;

- (void)checkMaintainState:(void(^)(BOOL isMaintainable))result;

- (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)())completion;
- (void)deleteTaleOfTaleInfo:(PBTaleInfo *)taleInfo completion:(void(^)())completion;

@end
