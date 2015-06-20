//
//  PBDataManager.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBDataManager.h"
#import "PBTale+Utility.h"
#import "PBScene+Utility.h"
#import "CoreData+MagicalRecord.h"

@implementation PBDataManager

+ (void)createTaleWithSceneInfos:(NSArray *)sceneInfos completion:(void(^)(BOOL success, NSError *error))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        PBTale* tale = [PBTale MR_createInContext:context];
        tale.timestamp = [NSDate date];
        NSInteger order = 0;
        for (PBSceneInfo* sceneInfo in sceneInfos) {
            PBScene* scene = [PBScene MR_createInContext:context];
            [scene updateFromSceneInfo:sceneInfo];
            scene.order = @(order++);
            scene.tale = tale;
        }
    } completion:completion];
}

@end
