//
//  PBTaleInfo.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PBTaleInfo : NSObject

@property (nonatomic, strong) NSManagedObjectID* objectId;
@property (nonatomic, strong) NSDate* timestamp;
@property (nonatomic, strong) NSArray* sceneInfos;

- (NSURL *)coverAssetURL;

@end
