//
//  PBWireframe.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe.h"
#import "PBTaleDetailViewController.h"

@implementation PBWireframe

+ (UIViewController *)rootViewController {
    UIViewController* viewController = [[UIStoryboard storyboardWithName:@"PBTale" bundle:nil] instantiateViewControllerWithIdentifier:@"TaleList"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

+ (void)moveToTaleDetailViewControllerFrom:(UIViewController *)sourceViewController withParams:(NSDictionary *)params {
    PBTaleDetailViewController* viewController = [[UIStoryboard storyboardWithName:@"PBTale" bundle:nil] instantiateViewControllerWithIdentifier:@"TaleDetail"];
    PBSceneGroupPresenter* sceneGroupPresenter = [PBSceneGroupPresenter new];
    sceneGroupPresenter.params = params;
    viewController.sceneGroupPresenter = sceneGroupPresenter;
    [sourceViewController.navigationController pushViewController:viewController animated:YES];
}

@end
