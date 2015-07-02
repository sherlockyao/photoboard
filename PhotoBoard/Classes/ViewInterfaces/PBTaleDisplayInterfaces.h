//
//  PBTaleDisplayInterfaces.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/2/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>

// Lists

@protocol PBTaleListInterface <NSObject>

- (void)displayTales:(NSArray *)tales;

@end


@protocol PBSceneListInterface <NSObject>

- (void)displayScenes:(NSArray *)scenes;

@end


@protocol PBWordListInterface <NSObject>

- (void)displayWords:(NSArray *)words;

@end
