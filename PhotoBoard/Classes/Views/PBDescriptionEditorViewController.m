//
//  PBDescriptionEditorViewController.m
//  PhotoBoard
//
//  Created by Sherlock Yao on 7/10/15.
//  Copyright (c) 2015 Jaret. All rights reserved.
//

#import "PBDescriptionEditorViewController.h"
#import "PBConstants.h"

@interface PBDescriptionEditorViewController () <UITextFieldDelegate>

@property (nonatomic, assign) PBDescriptionEditorType currentEditorType;

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (PBDescriptionEditorTypeWord == self.currentEditorType) {
        [self.wordTextField becomeFirstResponder];
    } else {
        [self.noteTextView becomeFirstResponder];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self animateShowEditorViewWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] keyboardHeight:size.height];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self animateHideEditorViewWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Text Field

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (PBDescriptionEditorTypeWord != self.currentEditorType) {
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
    if (PBDescriptionEditorTypeWord == self.currentEditorType) {
        [self submiteWord];
    } else {
        [self submiteNote];
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self closeDescriptionEditor];
}

#pragma mark - Gesture Actions

- (void)singleTapDimmingViewGestureAction:(UITapGestureRecognizer *)gesture {
    [self closeDescriptionEditor];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self submiteWord];
    return NO;
}

#pragma mark - Logic Method

- (void)submiteWord {
    NSString* word = self.wordTextField.text;
    if ([self.delegate respondsToSelector:@selector(descriptionEditorViewController:didSubmitWord:)]) {
        [self.delegate descriptionEditorViewController:self didSubmitWord:word];
    }
    [self closeDescriptionEditor];
}

- (void)submiteNote {
    NSString* note = self.noteTextView.text;
    if ([self.delegate respondsToSelector:@selector(descriptionEditorViewController:didSubmitNote:)]) {
        [self.delegate descriptionEditorViewController:self didSubmitNote:note];
    }
    [self closeDescriptionEditor];
}

- (void)closeDescriptionEditor {
    [self.wordTextField resignFirstResponder];
    [self.noteTextView resignFirstResponder];
}

#pragma mark - Animations

- (void)animateShowEditorViewWithDuration:(NSTimeInterval)duration keyboardHeight:(CGFloat)keyboardHeight {
    if (keyboardHeight == self.editorViewBottomConstraint.constant) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.editorView.alpha = 1;
        self.dimmingMaskView.alpha = 0.54;
        self.editorViewBottomConstraint.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)animateHideEditorViewWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion {
    if (0 == self.editorViewBottomConstraint.constant) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
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
    NSNumber* type = [self.params objectForKey:PBParamKeyType];
    if (type) {
        self.currentEditorType = [type integerValue];
    } else {
        self.currentEditorType = PBDescriptionEditorTypeWord;
    }
}

- (void)configureViewComponents {
    self.editorView.alpha = 0;
    self.dimmingMaskView.alpha = 0;
    
    // dimming view
    UITapGestureRecognizer *tapDimmingViewRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapDimmingViewGestureAction:)];
    [self.dimmingMaskView addGestureRecognizer:tapDimmingViewRecognizer];
    
    // text field & view
    self.noteTextView.placeholder = @"描述";
    self.wordTextField.delegate = self;
    
    NSString* text = [self.params objectForKey:PBParamKeyText];
    if (PBDescriptionEditorTypeWord == self.currentEditorType) {
        self.wordTextField.text = text;
        self.wordTextField.hidden = NO;
        self.noteTextView.hidden = YES;
    } else {
        self.noteTextView.text = text;
        self.noteTextView.hidden = NO;
        self.wordTextField.hidden = YES;
    }
}

@end
