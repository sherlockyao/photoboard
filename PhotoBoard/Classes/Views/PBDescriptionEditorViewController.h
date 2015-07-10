//
//  PBDescriptionEditorViewController.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/10/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

typedef NS_ENUM(NSInteger, PBDescriptionEditorType) {
    PBDescriptionEditorTypeWord,
    PBDescriptionEditorTypeNote
};

@protocol PBDescriptionEditorViewControllerDelegate;

@interface PBDescriptionEditorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *dimmingMaskView;
@property (weak, nonatomic) IBOutlet UIView *editorView;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet SZTextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editorViewBottomConstraint;

@property (nonatomic, strong) NSDictionary* params;
@property (nonatomic, weak) id<PBDescriptionEditorViewControllerDelegate> delegate;

@end


@protocol PBDescriptionEditorViewControllerDelegate <NSObject>

@optional
- (void)descriptionEditorViewController:(PBDescriptionEditorViewController *)descriptionEditorViewController didSubmitWord:(NSString *)word;
- (void)descriptionEditorViewController:(PBDescriptionEditorViewController *)descriptionEditorViewController didSubmitNote:(NSString *)note;

@end
