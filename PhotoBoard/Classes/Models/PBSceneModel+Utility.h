//
//  PBScene+Utility.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBSceneModel.h"
#import "PBScene.h"

@interface PBSceneModel (Utility)

- (PBScene *)data;
- (void)updateFromData:(PBScene *)scene;

@end
