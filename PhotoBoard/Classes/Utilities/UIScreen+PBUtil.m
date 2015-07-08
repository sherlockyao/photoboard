//
//  UIScreen+PBUtil.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/8/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "UIScreen+PBUtil.h"

@implementation UIScreen (PBUtil)

+ (CGRect)bounds {
    return [[self mainScreen] bounds];
}

+ (CGFloat)screenWidth {
    return [[self mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[self mainScreen] bounds].size.height;
}

+ (BOOL)is3_5InchScreen {
    return 480 == [self screenHeight];
}

+ (BOOL)is4InchScreen {
    return 568 == [self screenHeight];
}

+ (BOOL)is4_7InchScreen {
    return 667 == [self screenHeight];
}

+ (BOOL)is5_5InchScreen {
    // Scale is only 3 when not in scaled mode for iPhone 6 Plus
    return 2.9 < [self mainScreen].scale;
}

@end
