//
//  PBScene+Utility.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneModel+Utility.h"

@implementation PBSceneModel (Utility)

- (PBScene *)data {
    PBScene* scene = [PBScene new];
    scene.word = self.word;
    scene.note = self.note;
    scene.assetURL = [NSURL URLWithString:self.assetURL];
    return scene;
}

- (void)updateFromData:(PBScene *)scene {
    self.word = scene.word;
    self.note = scene.note;
    self.assetURL = scene.assetURL.absoluteString;
}

@end
