//
//  PBWireframe.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBWireframe : NSObject

+ (UIViewController *)rootViewController;

+ (void)moveToTaleDetailViewControllerFrom:(UIViewController *)sourceViewController withParams:(NSDictionary *)params;

+ (void)presentWordSelectorViewControllerFrom:(UIViewController *)sourceViewController;
+ (void)presentDescriptionEditorViewControllerFrom:(UIViewController *)sourceViewController withParams:(NSDictionary *)params;

@end
