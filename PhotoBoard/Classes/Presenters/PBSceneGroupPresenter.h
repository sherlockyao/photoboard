//
//  PBSceneGroupPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBTaleDisplayInterfaces.h"
#import "PBTaggedDisplayInterfaces.h"

@interface PBSceneGroupPresenter : NSObject

@property (nonatomic, strong) NSDictionary* params;

@property (nonatomic, weak) id<PBSceneListInterface> sceneList;
@property (nonatomic, weak) id<PBProcessHUDInterface> processHUD;

- (void)loadScenes;

@end
