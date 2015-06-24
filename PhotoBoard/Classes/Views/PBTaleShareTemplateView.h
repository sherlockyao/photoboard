//
//  PBTaleShareTemplateView.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/24/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBTaleShareTemplateView : UIView

- (void)generateSnapshotForSceneInfos:(NSArray *)sceneInfos result:(void(^)(UIImage* snapshot))result;

@end
