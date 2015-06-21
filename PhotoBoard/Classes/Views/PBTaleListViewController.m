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
#import "PBTaleCell.h"
#import "PBSceneInfo.h"
#import "PBConstants.h"
#import "PBWireFrame.h"

static NSString *const TaleCellReuseIdentifier = @"TaleCell";


@interface PBTaleListViewController () <UITableViewDataSource, UITableViewDelegate, PBTaleCellDelegate, ELCImagePickerControllerDelegate, PBTaleListInterface>

@property (nonatomic, strong) NSMutableArray* taleInfos;

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
    self.taleInfos = [NSMutableArray arrayWithArray:taleInfos];
    [self.taleTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taleInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBTaleCell* cell = [tableView dequeueReusableCellWithIdentifier:TaleCellReuseIdentifier forIndexPath:indexPath];
    [cell displayTaleInfo:self.taleInfos[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: handle selection
}

#pragma mark - PBTaleCellDelegate

- (void)taleCellDidClickDeleteButton:(PBTaleCell *)taleCell {
    NSIndexPath* indexPath = [self.taleTableView indexPathForCell:taleCell];
    PBTaleInfo* taleInfo = self.taleInfos[indexPath.row];
    
    // show alert controller
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否要删除故事？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.taleMaintainPresenter deleteTaleOfTaleInfo:taleInfo completion:^{
            [self.taleInfos removeObjectAtIndex:indexPath.row];
            [self.taleTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
    self.taleInfos = [NSMutableArray array];
}

- (void)configureViewComponents {
    // navigation
    self.navigationItem.title = @"PhotoBoard";
    
    // create button
    self.createButton.layer.cornerRadius = 30;
    
    // table view
    [self.taleTableView registerNib:[UINib nibWithNibName:@"PBTaleCell" bundle:nil] forCellReuseIdentifier:TaleCellReuseIdentifier];
    self.taleTableView.rowHeight = 150;
    self.taleTableView.contentInset = UIEdgeInsetsMake(4, 0, 12, 0);
    self.taleTableView.delegate = self;
    self.taleTableView.dataSource = self;
    [self.taleTableView setNeedsLayout];
    
    // wire up interfaces
    self.taleGroupPresenter.taleList = self;
}

@end
