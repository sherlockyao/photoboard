//
//  ALAsset+PBUtil.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/2/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface ALAsset (PBUtil)

- (NSURL *)url;
- (UIImage *)thumbnailForPixelSize:(NSUInteger)size;

@end
