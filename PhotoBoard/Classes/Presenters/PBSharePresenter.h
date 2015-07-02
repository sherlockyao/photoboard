//
//  PBSharePresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTaggedDisplayInterfaces.h"

@interface PBSharePresenter : NSObject

@property (nonatomic, weak) id<PBProcessHUDInterface> processHUD;

- (void)shareScenes:(NSArray *)scenes from:(UIViewController *)viewController;

@end
