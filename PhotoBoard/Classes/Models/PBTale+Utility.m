//
//  PBTale+Utility.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTale+Utility.h"
#import "PBScene+Utility.h"

@implementation PBTale (Utility)

+ (NSArray *)taleInfosForTales:(NSArray *)tales {
    NSMutableArray* taleInfos = [NSMutableArray arrayWithCapacity:[tales count]];
    for (PBTale* tale in tales) {
        [taleInfos addObject:[tale taleInfo]];
    }
    return [NSArray arrayWithArray:taleInfos];
}

- (PBTaleInfo *)taleInfo {
    PBTaleInfo* info = [PBTaleInfo new];
    info.objectId = self.objectID;
    info.timestamp = self.timestamp;
    NSMutableArray* sceneInfos = [NSMutableArray arrayWithCapacity:[self.scenes count]];
    NSArray* scenes = [[self.scenes allObjects] sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    for (PBScene* scene in scenes) {
        [sceneInfos addObject:[scene sceneInfo]];
    }
    info.sceneInfos = [NSArray arrayWithArray:sceneInfos];
    return info;
}

@end
