//
//  PBTaleGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleGroupPresenter.h"
#import "PBTale+DataManager.h"

@implementation PBTaleGroupPresenter

- (void)loadTales {
    [self.taleList displayTales:[PBTaleModel findAllTales]];
}

@end
