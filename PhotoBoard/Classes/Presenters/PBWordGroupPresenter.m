//
//  PBWordGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordGroupPresenter.h"
#import "PBWord.h"

@implementation PBWordGroupPresenter

- (void)loadWords {
    NSArray* words = @[
                       [PBWord wordWithText:@"首先"],
                       [PBWord wordWithText:@"其次"],
                       [PBWord wordWithText:@"接着"],
                       [PBWord wordWithText:@"然后"],
                       [PBWord wordWithText:@"下一步"],
                       [PBWord wordWithText:@"最后"],
                       [PBWord wordWithText:@"比如"],
                       [PBWord wordWithText:@"或者"],
                       [PBWord wordWithText:@"因为"],
                       [PBWord wordWithText:@"所以"],
                       [PBWord wordWithText:@"但是"],
                       [PBWord wordWithText:@"由于"],
                       [PBWord wordWithText:@"本来"],
                       [PBWord wordWithText:@"其实"],
                       [PBWord wordWithText:@"结果"],
                       [PBWord wordWithText:@"原来"],
                       [PBWord wordWithText:@"虽然"],
                       [PBWord wordWithText:@"可是"],
                       [PBWord wordWithText:@"没一会"],
                       [PBWord wordWithText:@"没想到"]
                       ];    
    
    [self.wordList displayWords:words];
}

@end
