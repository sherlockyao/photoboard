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
#import "PBDescriptionEditorViewController.h"
#import <objc/message.h>

@interface PBWireframe ()

@property (nonatomic, strong) NSDictionary* ports;
@property (nonatomic, strong) NSDictionary* codes;
@property (nonatomic, strong) NSDictionary* decodes;
@property (nonatomic, strong) NSDictionary* destinations;

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

#pragma mark - Navigation Methods

- (void)defaultPushFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController {
    [sourceViewController.navigationController pushViewController:destinationViewController animated:YES];
}

- (void)overlayPresentFrom:(UIViewController *)sourceViewController to:(UIViewController *)destinationViewController {
    if (sourceViewController.navigationController) {
        [sourceViewController.navigationController presentViewController:destinationViewController animated:NO completion:nil];
    } else {
        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
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

- (UIViewController *)buildViewControllerWithCode:(NSString *)code {
    NSDictionary* context = [self.decodes objectForKey:code];
    if (!context) {
        return [UIViewController new];
    }
    NSString* selectorName = [context objectForKey:@"selector"];
    if (selectorName) {
        SEL selector = NSSelectorFromString(selectorName);
        return ((id (*)(id, SEL))objc_msgSend)(self, selector);
    } else {
        NSString* storyboardName = [context objectForKey:@"storyboard"];
        NSString* identifier = [context objectForKey:@"id"];
        return [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    }
}

- (void)configureDestinationViewController:(UIViewController *)destinationViewController withParams:(NSDictionary *)params forSourceViewController:(UIViewController *)sourceViewController {
    if ([destinationViewController isKindOfClass:[PBTaleListViewController class]]) {
        
        // Tale List
        PBTaleListViewController* viewController = (PBTaleListViewController *)destinationViewController;
        viewController.taleGroupPresenter = [PBTaleGroupPresenter new];
        viewController.taleMaintainPresenter = [PBTaleMaintainPresenter new];
        
    } else if ([destinationViewController isKindOfClass:[PBTaleDetailViewController class]]) {
        
        // Tale Detail
        PBTaleDetailViewController* viewController = (PBTaleDetailViewController *)destinationViewController;
        
        PBSceneGroupPresenter* sceneGroupPresenter = [PBSceneGroupPresenter new];
        sceneGroupPresenter.params = params;
        viewController.sceneGroupPresenter = sceneGroupPresenter;
        
        PBTaleMaintainPresenter* taleMaintainPresenter = [PBTaleMaintainPresenter new];
        taleMaintainPresenter.params = params;
        viewController.taleMaintainPresenter = taleMaintainPresenter;
        
        viewController.sharePresenter = [PBSharePresenter new];
        
    } else if ([destinationViewController isKindOfClass:[PBWordSelectorViewController class]]) {
        
        // Word Selector
        PBWordSelectorViewController* viewController = (PBWordSelectorViewController *)destinationViewController;
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        viewController.delegate = (id<PBWordSelectorViewControllerDelegate>)sourceViewController;
        
        viewController.wordGroupPresenter = [PBWordGroupPresenter new];
        
    } else if ([destinationViewController isKindOfClass:[PBDescriptionEditorViewController class]]) {
        
        // Description Editor
        PBDescriptionEditorViewController* viewController = (PBDescriptionEditorViewController *)destinationViewController;
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        viewController.delegate = (id<PBDescriptionEditorViewControllerDelegate>)sourceViewController;
        viewController.params = params;
        
    }
}

@end
