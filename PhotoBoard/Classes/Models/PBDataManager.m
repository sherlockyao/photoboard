//
//  PBDataManager.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBDataManager.h"
#import "PBTaleModel+Utility.h"
#import "PBSceneModel+Utility.h"
#import "CoreData+MagicalRecord.h"

@implementation PBDataManager

+ (void)createTaleModelWithScenes:(NSArray *)scenes completion:(void(^)(BOOL success, NSError *error))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        PBTaleModel* taleModel = [PBTaleModel MR_createInContext:context];
        taleModel.timestamp = [NSDate date];
        NSInteger order = 0;
        for (PBScene* scene in scenes) {
            PBSceneModel* sceneModel = [PBSceneModel MR_createInContext:context];
            [sceneModel updateFromData:scene];
            sceneModel.order = @(order++);
            sceneModel.tale = taleModel;
        }
    } completion:completion];
}

@end
