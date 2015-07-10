//
//  PBWord.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/25/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBWord : NSObject

@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UIColor* color;

+ (instancetype)wordWithText:(NSString *)text;

+ (UIColor *)colorForText:(NSString *)text;

@end
