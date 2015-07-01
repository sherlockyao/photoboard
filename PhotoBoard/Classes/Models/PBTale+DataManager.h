//
//  PBTale+DataManager.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleModel.h"

@interface PBTaleModel (DataManager)

+ (NSArray *)findAllTales;

+ (void)deleteByObjectId:(NSManagedObjectID *)objectId completion:(void(^)(BOOL success, NSError *error))completion;

@end
