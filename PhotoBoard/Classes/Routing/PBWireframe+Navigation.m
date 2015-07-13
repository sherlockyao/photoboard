//
//  PBWireframe+Navigation.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/13/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe+Navigation.h"

@implementation PBWireframe (Navigation)

- (void)defaultPopFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController completion:(PBWireframeCompletionBlock)completion {
    [sourceViewController.navigationController popViewControllerAnimated:YES];
    if (completion) {
        completion();
    }
}

- (void)defaultDismissFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController completion:(PBWireframeCompletionBlock)completion {
    [sourceViewController dismissViewControllerAnimated:YES completion:completion];
}

- (void)defaultPushFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController completion:(PBWireframeCompletionBlock)completion {
    [sourceViewController.navigationController pushViewController:destinationViewController animated:YES];
    if (completion) {
        completion();
    }
}

- (void)defaultPresentFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController completion:(PBWireframeCompletionBlock)completion {
    if (sourceViewController.navigationController) {
        [sourceViewController.navigationController presentViewController:destinationViewController animated:YES completion:completion];
    } else {
        [sourceViewController presentViewController:destinationViewController animated:YES completion:completion];
    }
}

- (void)overlayPresentFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController completion:(PBWireframeCompletionBlock)completion {
    if (sourceViewController.navigationController) {
        [sourceViewController.navigationController presentViewController:destinationViewController animated:NO completion:completion];
    } else {
        [sourceViewController presentViewController:destinationViewController animated:NO completion:completion];
    }
}

@end
