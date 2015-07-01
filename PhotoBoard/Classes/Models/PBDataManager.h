//
//  PBDataManager.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBDataManager : NSObject

+ (void)createTaleModelWithScenes:(NSArray *)scenes completion:(void(^)(BOOL success, NSError *error))completion;

@end
