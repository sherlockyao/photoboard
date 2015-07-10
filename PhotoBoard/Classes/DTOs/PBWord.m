//
//  PBWord.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWord.h"
#import "UIColor+PBUtil.h"
#import "NSArray+PBUtil.h"

@implementation PBWord

+ (instancetype)wordWithText:(NSString *)text {
    PBWord* word = [PBWord new];
    word.text = text;
    word.color = [self colorForText:text];
    return word;
}

+ (UIColor *)colorForText:(NSString *)text {
    // static color cache
    static NSMutableDictionary* randomColors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        randomColors = [NSMutableDictionary dictionary];
    });
    
    if (!text) {
        text = @"";
    }
    UIColor* color = [[self colorsDictionary] objectForKey:text];
    if (!color) {
        color = [randomColors objectForKey:text];
    }
    if (!color) {
        color = [[[self colorsDictionary] allValues] sample];
        [randomColors setObject:color forKey:text];
    }
    return color;
}

+ (NSDictionary *)colorsDictionary {
    static NSDictionary* colorsDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        colorsDictionary = @{
                             @"首先" : [UIColor colorWithHex:0x42a5f5],
                             @"其次" : [UIColor colorWithHex:0x3949ab],
                             @"接着" : [UIColor colorWithHex:0x7e57c2],
                             @"然后" : [UIColor colorWithHex:0xab47bc],
                             @"下一步" : [UIColor colorWithHex:0xef5350],
                             @"最后" : [UIColor colorWithHex:0xec407a],
                             @"比如" : [UIColor colorWithHex:0xf57c00],
                             @"或者" : [UIColor colorWithHex:0xffa726],
                             @"因为" : [UIColor colorWithHex:0x8bc34a],
                             @"所以" : [UIColor colorWithHex:0x00796b],
                             @"但是" : [UIColor colorWithHex:0x43a047],
                             @"由于" : [UIColor colorWithHex:0x3949ab],
                             @"本来" : [UIColor colorWithHex:0x7e57c2],
                             @"其实" : [UIColor colorWithHex:0xab47bc],
                             @"结果" : [UIColor colorWithHex:0xef5350],
                             @"原来" : [UIColor colorWithHex:0xec407a],
                             @"虽然" : [UIColor colorWithHex:0xf57c00],
                             @"可是" : [UIColor colorWithHex:0xffa726],
                             @"没一会" : [UIColor colorWithHex:0x00796b],
                             @"没想到" : [UIColor colorWithHex:0x43a047]
                             };
    });
    return colorsDictionary;
}

@end
