//
//  UIBarButtonItem+PBUtil.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "UIBarButtonItem+PBUtil.h"

@implementation UIBarButtonItem (PBUtil)

+ (instancetype)barItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage size:(CGSize)size target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, size.width, size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
