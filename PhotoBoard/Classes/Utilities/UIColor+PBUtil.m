//
//  UIColor+PBUtil.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "UIColor+PBUtil.h"

@implementation UIColor (PBUtil)

+ (UIColor *)colorWithHex:(long)hexColor {
    return [self colorWithHex:hexColor alpha:1.f];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF)) / 255.f;
    return [self colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
