//
//  PBSharePresenter.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/21/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTaleInfo.h"

@interface PBSharePresenter : NSObject

- (void)shareTaleInfo:(PBTaleInfo *)taleInfo from:(UIViewController *)viewController;

@end
