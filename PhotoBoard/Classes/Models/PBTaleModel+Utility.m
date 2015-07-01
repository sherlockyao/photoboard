//
//  PBTale+Utility.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleModel+Utility.h"
#import "PBSceneModel+Utility.h"

@implementation PBTaleModel (Utility)

+ (NSArray *)dataForTaleModels:(NSArray *)taleModels {
    NSMutableArray* tales = [NSMutableArray arrayWithCapacity:[taleModels count]];
    for (PBTaleModel* taleModel in taleModels) {
        [tales addObject:[taleModel data]];
    }
    return [NSArray arrayWithArray:tales];
}

- (PBTale *)data {
    PBTale* tale = [PBTale new];
    tale.objectId = self.objectID;
    tale.timestamp = self.timestamp;
    NSMutableArray* scenes = [NSMutableArray arrayWithCapacity:[self.scenes count]];
    NSArray* sceneModels = [[self.scenes allObjects] sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    for (PBSceneModel* sceneModel in sceneModels) {
        [scenes addObject:[sceneModel data]];
    }
    tale.scenes = [NSArray arrayWithArray:scenes];
    return tale;
}

@end
