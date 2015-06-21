//
//  UIBarButtonItem+PBUtil.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (PBUtil)

+ (instancetype)barItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage size:(CGSize)size target:(id)target action:(SEL)action;

@end
