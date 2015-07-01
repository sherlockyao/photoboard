//
//  PBSceneInfo.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PBScene : NSObject

@property (nonatomic, strong) NSString* word;
@property (nonatomic, strong) NSString* note;
@property (nonatomic, strong) NSURL* assetURL;
@property (nonatomic, strong) ALAsset* asset;

@end
