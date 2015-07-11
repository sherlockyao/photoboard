//
//  PNSceneListView.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTaleDisplayInterfaces.h"

@protocol PBSceneListViewDelegate;

@interface PBSceneListView : UIView <PBSceneListInterface>

@property (weak, nonatomic) IBOutlet UITableView *sceneTableView;

@property (readonly, nonatomic, strong) NSArray* scenes;
@property (nonatomic, weak) id<PBSceneListViewDelegate> delegate;

- (void)displayUpdatedWord:(NSString *)word forRowIndex:(NSUInteger)index;
- (void)displayUpdatedNote:(NSString *)note forRowIndex:(NSUInteger)index;

- (CGFloat)preferredHeigh;

@end


@protocol PBSceneListViewDelegate <NSObject>

@optional
- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditWord:(NSString *)word atRowIndex:(NSInteger)index;
- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditNote:(NSString *)note atRowIndex:(NSInteger)index;
- (void)sceneListView:(PBSceneListView *)sceneListView didToggleTopOffScreenState:(BOOL)isScrollOffTop;

@end
