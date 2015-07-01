//
//  PBTaleMaintainPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBTale.h"

@interface PBTaleMaintainPresenter : NSObject

@property (nonatomic, strong) NSDictionary* params;

- (void)checkMaintainState:(void(^)(BOOL isMaintainable))result;

- (void)createTaleWithScenes:(NSArray *)scenes completion:(void(^)())completion;
- (void)deleteTale:(PBTale *)tale completion:(void(^)())completion;

@end
