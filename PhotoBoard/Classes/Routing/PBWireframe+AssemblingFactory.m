//
//  PBWireframe+AssemblingFactory.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/13/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBWireframe+AssemblingFactory.h"
#import "PBTaleListViewController.h"
#import "PBTaleDetailViewController.h"
#import "PBWordSelectorViewController.h"
#import "PBDescriptionEditorViewController.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <objc/message.h>

@implementation PBWireframe (AssemblingFactory)

- (UIViewController *)buildViewControllerWithCode:(NSString *)code params:(NSDictionary *)params {
    NSDictionary* context = [self.decodes objectForKey:code];
    if (!context) {
        return [UIViewController new];
    }
    NSString* selectorName = [context objectForKey:@"selector"];
    if (selectorName) {
        SEL selector = NSSelectorFromString(selectorName);
        return ((id (*)(id, SEL, id))objc_msgSend)(self, selector, params);
    } else {
        NSString* storyboardName = [context objectForKey:@"storyboard"];
        NSString* identifier = [context objectForKey:@"id"];
        return [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    }
}

- (UIViewController *)buildELCImagePickerControllerWithParams:(NSDictionary *)params {
    ELCImagePickerController *imagePicker = [[ELCImagePickerController alloc] initImagePicker];
    imagePicker.returnsImage = NO;
    imagePicker.maximumImagesCount = 9;
    imagePicker.onOrder = YES;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    return imagePicker;
}

- (UIViewController *)buildActivityViewControllerWithParams:(NSDictionary *)params {
    UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:[params objectForKey:@"activityItems"] applicationActivities:[params objectForKey:@"applicationActivities"]];
    activityViewController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll];
    
    return activityViewController;
}

- (UIViewController *)buildAlertControllerWithParams:(NSDictionary *)params {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[params objectForKey:@"title"] message:[params objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
    NSArray* actions = [params objectForKey:@"actions"];
    if (actions) {
        for (UIAlertAction* action in actions) {
            [alertController addAction:action];
        }
    }
    return alertController;
}

// Here is the long list for configuring all view classes
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
        
    } else if ([destinationViewController isKindOfClass:[ELCImagePickerController class]]) {
        
        // Description Editor
        ELCImagePickerController* viewController = (ELCImagePickerController *)destinationViewController;
        viewController.imagePickerDelegate = (id<ELCImagePickerControllerDelegate>)sourceViewController;
        
    }
}

@end
