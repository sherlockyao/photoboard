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

@implementation PBTale (DataManager)

+ (NSArray *)findAllTaleInfos {
    NSArray* tales = [self MR_findAllSortedBy:@"timestamp" ascending:NO];
    return [self taleInfosForTales:tales];
}

+ (void)deleteByObjectId:(NSManagedObjectID *)objectId completion:(void(^)(BOOL success, NSError *error))completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        NSError* error = nil;
        PBTale* tale = (PBTale *)[context existingObjectWithID:objectId error:&error];
        [tale MR_deleteInContext:context];
    } completion:completion];
}

@end
