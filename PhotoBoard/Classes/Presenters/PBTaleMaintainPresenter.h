//
//  PBTaleMaintainPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBTaleMaintainPresenter : NSObject

- (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)())completion;

@end
