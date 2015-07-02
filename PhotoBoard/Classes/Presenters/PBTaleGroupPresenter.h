//
//  PBTaleGroupPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBTaleDisplayInterfaces.h"

@interface PBTaleGroupPresenter : NSObject

@property (nonatomic, weak) id<PBTaleListInterface> taleList;

- (void)loadTales;

@end
