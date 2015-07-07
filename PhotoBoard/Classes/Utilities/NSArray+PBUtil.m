//
//  NSArray+PBUtil.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/7/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "NSArray+PBUtil.h"

@implementation NSArray (PBUtil)

- (id)sample {
    if (self.count == 0) {
        return nil;
    }
    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    return self[index];
}

@end
