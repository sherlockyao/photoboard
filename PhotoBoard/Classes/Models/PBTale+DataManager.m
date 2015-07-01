//
//  PBTale+DataManager.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTale+DataManager.h"
#import "PBTale+Utility.h"
#import "CoreData+MagicalRecord.h"

@implementation PBTaleModel (DataManager)

+ (NSArray *)findAllTaleInfos {
    NSArray* taleModels = [self MR_findAllSortedBy:@"timestamp" ascending:NO];
    return [self taleInfosForTales:taleModels];
}

+ (void)deleteByObjectId:(NSManagedObjectID *)objectId completion:(void(^)(BOOL success, NSError *error))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        NSError* error = nil;
        PBTaleModel* tale = (PBTaleModel *)[context existingObjectWithID:objectId error:&error];
        [tale MR_deleteInContext:context];
    } completion:completion];
}

@end
