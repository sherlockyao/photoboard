//
//  PBWordGroupPresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBTaleDisplayInterfaces.h"

@interface PBWordGroupPresenter : NSObject

@property (nonatomic, weak) id<PBWordListInterface> wordList;

- (void)loadWords;

@end
