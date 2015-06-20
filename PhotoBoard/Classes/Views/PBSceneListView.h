//
//  PNSceneListView.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 6/20/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PBSceneListViewDelegate;

@interface PBSceneListView : UIView

@property (weak, nonatomic) IBOutlet UITableView *sceneTableView;

@property(nonatomic, weak) id<PBSceneListViewDelegate> delegate;

- (void)displayUpdatedWord:(NSString *)word forRowIndex:(NSUInteger)index;
- (void)displayUpdatedNote:(NSString *)note forRowIndex:(NSUInteger)index;

@end


@protocol PBSceneListViewDelegate <NSObject>

@optional
- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditWordAtRowIndex:(NSUInteger)index;
- (void)sceneListView:(PBSceneListView *)sceneListView didSelectEditNoteAtRowIndex:(NSUInteger)index;

@end
