//
//  PBWireframe+AssemblingFactory.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/13/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe.h"

@interface PBWireframe (AssemblingFactory)

- (UIViewController *)buildViewControllerWithCode:(NSString *)code;


- (void)configureDestinationViewController:(UIViewController *)destinationViewController withParams:(NSDictionary *)params forSourceViewController:(UIViewController *)sourceViewController;

@end
