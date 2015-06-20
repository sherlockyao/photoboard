//
//  PBScene+Utility.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBScene+Utility.h"

@implementation PBScene (Utility)

- (PBSceneInfo *)sceneInfo {
    PBSceneInfo* info = [PBSceneInfo new];
    info.word = self.word;
    info.note = self.note;
    info.assetURL = [NSURL URLWithString:self.assetURL];
    return info;
}

- (void)updateFromSceneInfo:(PBSceneInfo *)sceneInfo {
    self.word = sceneInfo.word;
    self.note = sceneInfo.note;
    self.assetURL = sceneInfo.assetURL.absoluteString;
}

@end
