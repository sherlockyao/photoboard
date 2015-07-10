//
//  PBDescriptionEditorViewController.h
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/10/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBDescriptionEditorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *dimmingMaskView;
@property (weak, nonatomic) IBOutlet UIView *editorView;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editorViewBottomConstraint;

@end
