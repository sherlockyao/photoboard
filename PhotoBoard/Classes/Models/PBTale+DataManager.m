//
//  PBTale+DataManager.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTale+DataManager.h"
#import "PBTaleModel+Utility.h"
#import "CoreData+MagicalRecord.h"

@implementation PBTaleModel (DataManager)

+ (NSArray *)findAllTales {
    NSArray* taleModels = [self MR_findAllSortedBy:@"timestamp" ascending:NO];
    return [self dataForTaleModels:taleModels];
}

+ (void)deleteByObjectId:(NSManagedObjectID *)objectId completion:(void(^)(BOOL success, NSError *error))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        NSError* error = nil;
        PBTaleModel* taleModel = (PBTaleModel *)[context existingObjectWithID:objectId error:&error];
        [taleModel MR_deleteInContext:context];
    } completion:completion];
}

@end
