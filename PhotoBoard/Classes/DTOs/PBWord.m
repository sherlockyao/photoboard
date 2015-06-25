//
//  PBWord.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWord.h"

@implementation PBWord

+ (instancetype)wordWithText:(NSString *)text color:(UIColor *)color {
    PBWord* word = [PBWord new];
    word.text = text;
    word.color = color;
    return word;
}

@end
