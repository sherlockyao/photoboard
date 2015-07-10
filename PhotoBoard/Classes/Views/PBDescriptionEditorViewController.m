//
//  PBDescriptionEditorViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/10/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBDescriptionEditorViewController.h"

@interface PBDescriptionEditorViewController ()

@property (nonatomic, assign) NSUInteger currentEditMode; // 0: edit word, 1: edit note

@end

@implementation PBDescriptionEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // configure
    [self configureProperties];
    [self configureViewComponents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self animateShowEditorViewWithKeyboardHeight:size.height];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self animateHideEditorViewWithCompletion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Text Field

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (0 != self.currentEditMode) {
        return;
    }
    NSString* text = self.wordTextField.text;
    NSString* language = [self.wordTextField.textInputMode primaryLanguage];
    if ([language isEqualToString:@"zh-Hans"]) {
        UITextRange* selectedRange = [self.wordTextField markedTextRange];
        UITextPosition* position = [self.wordTextField positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (text.length > 3) {
                self.wordTextField.text = [text substringToIndex:3];
            }
        }
    } else {
        if (text.length > 3) {
            self.wordTextField.text = [text substringToIndex:3];
        }
    }
}

#pragma mark - IB Actions

- (IBAction)doneButtonTouchUpInside:(id)sender {
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
}

#pragma mark - Animations

- (void)animateShowEditorViewWithKeyboardHeight:(CGFloat)keyboardHeight {
    if (keyboardHeight == self.editorViewBottomConstraint.constant) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.editorView.alpha = 1;
        self.dimmingMaskView.alpha = 0.54;
        self.editorViewBottomConstraint.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)animateHideEditorViewWithCompletion:(void (^)(void))completion {
    if (0 == self.editorViewBottomConstraint.constant) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.editorView.alpha = 0;
        self.dimmingMaskView.alpha = 0;
        self.editorViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Configuration

- (void)configureProperties {

}

- (void)configureViewComponents {
    self.editorView.alpha = 0;
    self.dimmingMaskView.alpha = 0;
}

@end
