//
//  PBWireframe+Navigation.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/13/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe+Navigation.h"

@implementation PBWireframe (Navigation)

- (void)defaultPushFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController {
    [sourceViewController.navigationController pushViewController:destinationViewController animated:YES];
}

- (void)defaultPresentFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController {
    if (sourceViewController.navigationController) {
        [sourceViewController.navigationController presentViewController:destinationViewController animated:YES completion:nil];
    } else {
        [sourceViewController presentViewController:destinationViewController animated:YES completion:nil];
    }
}

- (void)overlayPresentFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController {
    if (sourceViewController.navigationController) {
        [sourceViewController.navigationController presentViewController:destinationViewController animated:NO completion:nil];
    } else {
        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
    }
}

@end
