//
//  ViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleListViewController.h"
#import "ELCImagePickerController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "PBSceneInfo.h"
#import "PBConstants.h"
#import "PBWireFrame.h"

@interface PBTaleListViewController () <ELCImagePickerControllerDelegate>

@end

@implementation PBTaleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createButtonTouchUpInside:(id)sender {
    ELCImagePickerController *imagePicker = [[ELCImagePickerController alloc] initImagePicker];
    imagePicker.imagePickerDelegate = self;
    imagePicker.returnsImage = NO;
    imagePicker.maximumImagesCount = 5;
    imagePicker.onOrder = YES;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray* sceneInfos = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary* map in info) {
        PBSceneInfo* sceneInfo = [PBSceneInfo new];
        sceneInfo.assetURL = [map objectForKey:UIImagePickerControllerReferenceURL];
        [sceneInfos addObject:sceneInfo];
    }
    NSDictionary* params = @{ ParamKeySceneInfos : sceneInfos };
    [PBWireframe moveToTaleDetailViewControllerFrom:self withParams:params];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
