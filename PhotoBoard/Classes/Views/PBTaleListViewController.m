//
//  ViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBTaleListViewController.h"
#import "ELCImagePickerController.h"
#import "PBTaleCell.h"
#import "PBScene.h"
#import "PBConstants.h"
#import "PBWireFrame.h"

static NSString *const TaleCellReuseIdentifier = @"TaleCell";


@interface PBTaleListViewController () <UITableViewDataSource, UITableViewDelegate, PBTaleCellDelegate, ELCImagePickerControllerDelegate, PBTaleListInterface>

@property (nonatomic, strong) NSMutableArray* tales;

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
    [self.navigationController setNavigationBarHidden:NO];
    [self.taleGroupPresenter loadTales];
}

#pragma mark - IB Actions

- (IBAction)createButtonTouchUpInside:(id)sender {
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortPicker from:self];
}

#pragma mark - PBTaleListInterface

- (void)displayTales:(NSArray *)tales {
    self.tales = [NSMutableArray arrayWithArray:tales];
    [self.taleTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tales count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PBTaleCell* cell = [tableView dequeueReusableCellWithIdentifier:TaleCellReuseIdentifier forIndexPath:indexPath];
    [cell displayTale:self.tales[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PBTale* tale = self.tales[indexPath.row];
    NSDictionary* params = @{ PBParamKeyTale : tale };
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortDetail withParams:params from:self];
}

#pragma mark - PBTaleCellDelegate

- (void)taleCellDidClickDeleteButton:(PBTaleCell *)taleCell {
    NSIndexPath* indexPath = [self.taleTableView indexPathForCell:taleCell];
    PBTale* tale = self.tales[indexPath.row];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.taleMaintainPresenter deleteTale:tale completion:^{
            [self.tales removeObjectAtIndex:indexPath.row];
            [self.taleTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }];
    NSDictionary* params = @{
                             @"message" : @"是否要删除故事？",
                             @"actions" : @[ cancelAction, otherAction ]
                             };
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortAlert withParams:params from:self];
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortBack from:picker];
    
    if (0 == [info count]) {
        return; // quit if no photo is selected
    }
    NSMutableArray* scenes = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary* map in info) {
        PBScene* scene = [PBScene new];
        scene.assetURL = [map objectForKey:UIImagePickerControllerReferenceURL];
        [scenes addObject:scene];
    }
    NSDictionary* params = @{ PBParamKeySceneList : scenes };
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortDetail withParams:params from:self];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [[PBWireframe defaultWireframe] navigateToPort:PBWireframePortBack from:picker];
}

#pragma mark - Configuration

- (void)configureProperties {
    self.tales = [NSMutableArray array];
}

- (void)configureViewComponents {
    // navigation
    self.navigationItem.title = @"串照片";
    
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
