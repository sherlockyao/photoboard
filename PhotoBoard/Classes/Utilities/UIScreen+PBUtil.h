//
//  UIScreen+PBUtil.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/8/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (PBUtil)

+ (CGRect)bounds;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (BOOL)is3_5InchScreen;
+ (BOOL)is4InchScreen;
+ (BOOL)is4_7InchScreen;
+ (BOOL)is5_5InchScreen;

@end
