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

@interface PBTaleListViewController () <ELCImagePickerControllerDelegate, PBTaleListInterface>

@property (nonatomic, strong) NSArray* taleInfos;

@end

@implementation PBTaleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // configure
    [self configureProperties];
    [self configureViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.taleGroupPresenter loadTaleInfos];
}

#pragma mark - IB Actions

- (IBAction)createButtonTouchUpInside:(id)sender {
    ELCImagePickerController *imagePicker = [[ELCImagePickerController alloc] initImagePicker];
    imagePicker.imagePickerDelegate = self;
    imagePicker.returnsImage = NO;
    imagePicker.maximumImagesCount = 5;
    imagePicker.onOrder = YES;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - PBTaleListInterface

- (void)displayTaleInfos:(NSArray *)taleInfos {
    self.taleInfos = taleInfos;
    [self.taleTableView reloadData];
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (0 == [info count]) {
        return; // quit if no photo is selected
    }
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

#pragma mark - Configuration

- (void)configureProperties {
    self.taleInfos = @[];
}

- (void)configureViewComponents {
    self.createButton.layer.cornerRadius = 30;
    self.taleGroupPresenter.taleList = self;
}

@end
