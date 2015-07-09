//
//  PBWireframe.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe.h"
#import "PBTaleListViewController.h"
#import "PBTaleDetailViewController.h"
#import "PBWordSelectorViewController.h"

@implementation PBWireframe

+ (UIViewController *)rootViewController {
    PBTaleListViewController* viewController = [[UIStoryboard storyboardWithName:@"PBTale" bundle:nil] instantiateViewControllerWithIdentifier:@"TaleList"];
    
    // presenters
    viewController.taleGroupPresenter = [PBTaleGroupPresenter new];
    viewController.taleMaintainPresenter = [PBTaleMaintainPresenter new];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

+ (void)moveToTaleDetailViewControllerFrom:(UIViewController *)sourceViewController withParams:(NSDictionary *)params {
    PBTaleDetailViewController* viewController = [[UIStoryboard storyboardWithName:@"PBTale" bundle:nil] instantiateViewControllerWithIdentifier:@"TaleDetail"];
    
    // presenters
    PBSceneGroupPresenter* sceneGroupPresenter = [PBSceneGroupPresenter new];
    sceneGroupPresenter.params = params;
    viewController.sceneGroupPresenter = sceneGroupPresenter;
    
    PBTaleMaintainPresenter* taleMaintainPresenter = [PBTaleMaintainPresenter new];
    taleMaintainPresenter.params = params;
    viewController.taleMaintainPresenter = taleMaintainPresenter;
    
    viewController.sharePresenter = [PBSharePresenter new];
    viewController.wordGroupPresenter = [PBWordGroupPresenter new];
    
    [sourceViewController.navigationController pushViewController:viewController animated:YES];
}

+ (void)presentWordSelectorViewControllerFrom:(UIViewController *)sourceViewController {
    PBWordSelectorViewController* viewController = [[UIStoryboard storyboardWithName:@"PBTale" bundle:nil] instantiateViewControllerWithIdentifier:@"WordSelector"];
    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    viewController.delegate = (id<PBWordSelectorViewControllerDelegate>)sourceViewController;
    
    // presenters
    viewController.wordGroupPresenter = [PBWordGroupPresenter new];
    
//    sourceViewController.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [sourceViewController.navigationController presentViewController:viewController animated:NO completion:nil];
}

@end
