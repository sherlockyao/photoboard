//
//  PBWordGroupPresenter.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWordGroupPresenter.h"
#import "PBWord.h"
#import "UIColor+PBUtil.h"

@implementation PBWordGroupPresenter

- (void)loadWords {
    NSArray* words = @[
                       [PBWord wordWithText:@"首先" color:[UIColor colorWithHex:0x42a5f5]],
                       [PBWord wordWithText:@"其次" color:[UIColor colorWithHex:0x3949ab]],
                       [PBWord wordWithText:@"接着" color:[UIColor colorWithHex:0x7e57c2]],
                       [PBWord wordWithText:@"然后" color:[UIColor colorWithHex:0xab47bc]],
                       [PBWord wordWithText:@"下一步" color:[UIColor colorWithHex:0xef5350]],
                       [PBWord wordWithText:@"最后" color:[UIColor colorWithHex:0xec407a]],
                       [PBWord wordWithText:@"比如" color:[UIColor colorWithHex:0xf57c00]],
                       [PBWord wordWithText:@"或者" color:[UIColor colorWithHex:0xffa726]],
                       [PBWord wordWithText:@"因为" color:[UIColor colorWithHex:0x8bc34a]],
                       [PBWord wordWithText:@"所以" color:[UIColor colorWithHex:0x00796b]],
                       [PBWord wordWithText:@"但是" color:[UIColor colorWithHex:0x43a047]],
                       [PBWord wordWithText:@"由于" color:[UIColor colorWithHex:0x3949ab]],
                       [PBWord wordWithText:@"本来" color:[UIColor colorWithHex:0x7e57c2]],
                       [PBWord wordWithText:@"其实" color:[UIColor colorWithHex:0xab47bc]],
                       [PBWord wordWithText:@"结果" color:[UIColor colorWithHex:0xef5350]],
                       [PBWord wordWithText:@"原来" color:[UIColor colorWithHex:0xec407a]],
                       [PBWord wordWithText:@"虽然" color:[UIColor colorWithHex:0xf57c00]],
                       [PBWord wordWithText:@"可是" color:[UIColor colorWithHex:0xffa726]],
                       [PBWord wordWithText:@"没一会" color:[UIColor colorWithHex:0x00796b]],
                       [PBWord wordWithText:@"没想到" color:[UIColor colorWithHex:0x43a047]]
                       ];    
    
    [self.wordList displayWords:words];
}

#pragma mark - Factory

@end
