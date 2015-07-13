//
//  PBWireframe.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PBWireframePort) {
    // General Ports
    PBWireframePortRoot = 1,
    PBWireframePortBack = 2,
    PBWireframePortDismiss = 3,
    
    // Content Ports
    PBWireframePortList = 201,
    PBWireframePortDetail = 202,
    
    // Action Ports
    PBWireframePortAdd = 401,
    PBWireframePortEdit = 402,
    PBWireframePortDelete = 403,
    
    // Modal Ports
    PBWireframePortPicker = 801,
    PBWireframePortEditor = 802,
    PBWireframePortShare = 803,
    PBWireframePortAlert = 804
};

typedef void (^PBWireframeCompletionBlock)();

@interface PBWireframe : NSObject

@property (readonly, nonatomic, strong) NSDictionary* ports;
@property (readonly, nonatomic, strong) NSDictionary* codes;
@property (readonly, nonatomic, strong) NSDictionary* decodes;
@property (readonly, nonatomic, strong) NSDictionary* destinations;

+ (instancetype)defaultWireframe;

- (UIViewController *)rootViewController;

- (void)navigateToPort:(PBWireframePort)port from:(UIViewController *)sourceViewController;
- (void)navigateToPort:(PBWireframePort)port withParams:(NSDictionary *)params from:(UIViewController *)sourceViewController;
- (void)navigateToPort:(PBWireframePort)port withParams:(NSDictionary *)params from:(UIViewController *)sourceViewController completion:(PBWireframeCompletionBlock)completion;
- (void)navigateToPort:(PBWireframePort)port withPortSerialNumber:(NSUInteger)serialNumber params:(NSDictionary *)params from:(UIViewController *)sourceViewController completion:(PBWireframeCompletionBlock)completion;

@end
