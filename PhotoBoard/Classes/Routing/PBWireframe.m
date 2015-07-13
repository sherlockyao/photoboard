//
//  PBWireframe.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe.h"
#import "PBWireframe+AssemblingFactory.h"
#import <objc/message.h>

@interface PBWireframe ()

@property (readwrite, nonatomic, strong) NSDictionary* ports;
@property (readwrite, nonatomic, strong) NSDictionary* codes;
@property (readwrite, nonatomic, strong) NSDictionary* decodes;
@property (readwrite, nonatomic, strong) NSDictionary* destinations;

@end


@implementation PBWireframe

+ (instancetype)defaultWireframe {
    static PBWireframe* wireframe = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        wireframe = [PBWireframe new];
    });
    return wireframe;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"PBWireframe" ofType:@"plist"];
        NSDictionary* plist = [[NSDictionary alloc] initWithContentsOfFile:path];
        _ports = [plist objectForKey:@"Ports"];
        _codes = [plist objectForKey:@"Codes"];
        _decodes = [plist objectForKey:@"Decodes"];
        _destinations = [plist objectForKey:@"Destinations"];
    }
    return self;
}


- (UIViewController *)rootViewController {
    UIViewController* viewController = [self buildViewControllerWithCode:@"T1"];
    [self configureDestinationViewController:viewController withParams:nil forSourceViewController:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)navigateToPort:(PBWireframePort)port from:(UIViewController *)sourceViewController {
    [self navigateToPort:port withParams:nil from:sourceViewController];
}

- (void)navigateToPort:(PBWireframePort)port withParams:(NSDictionary *)params from:(UIViewController *)sourceViewController {
    [self navigateToPort:port withPortSerialNumber:0 params:params from:sourceViewController];
}

- (void)navigateToPort:(PBWireframePort)port withPortSerialNumber:(NSUInteger)serialNumber params:(NSDictionary *)params from:(UIViewController *)sourceViewController {
    NSString* destinationKey = [self destinationKeyForPort:port serialNumber:serialNumber sourceViewController:sourceViewController];
    NSDictionary* destination = [self.destinations objectForKey:destinationKey];
    if (destination) {
        NSString* targetCode = [destination objectForKey:@"target"];
        UIViewController* destinationViewController = [self buildViewControllerWithCode:targetCode];
        [self configureDestinationViewController:destinationViewController withParams:params forSourceViewController:sourceViewController];
        SEL selector = NSSelectorFromString([destination objectForKey:@"selector"]);
        ((void (*)(id, SEL, id, id))objc_msgSend)(self, selector, sourceViewController, destinationViewController);
    }
}

#pragma mark - Helper Methods

- (NSString *)destinationKeyForPort:(PBWireframePort)port serialNumber:(NSUInteger)serialNumber sourceViewController:(UIViewController *)sourceViewController {
    NSString* sourceCode = [self.codes objectForKey:NSStringFromClass([sourceViewController class])];
    NSString* portName = [self.ports objectForKey:[NSString stringWithFormat:@"%ld", (long)port]];
    if (0 == serialNumber) {
        return [NSString stringWithFormat:@"%@-%@", sourceCode, portName];
    } else {
        return [NSString stringWithFormat:@"%@-%@-%lu", sourceCode, portName, (long)serialNumber];
    }
}

@end
