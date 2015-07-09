//
//  inputAccessoryViewController.m
//  inputAccessoryView
//
//  Created by Admin on 04.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "inputAccessoryViewController.h"
#import "UIResponder+FirstResponder.h"

@interface inputAccessoryViewController () <UITextFieldDelegate>

@end

@implementation inputAccessoryViewController {
    CGFloat height;
    NSLayoutConstraint *_heightConstraint;
}

- (void)dealloc
{
    NSLog(@"dealloc %@", [UIResponder currentFirstResponder]);
}


- (void)loadView
{
    [super loadView];
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.superview.frame), 70);
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    _textField = [[TextField alloc] initWithInputAccessorViewController:self];
    _textField = [TextField new];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.borderColor = [UIColor grayColor].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_textField];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[textField]-10-|" options:0 metrics:nil views:@{ @"textField": _textField }]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField]-10-|" options:0 metrics:nil views:@{ @"textField": _textField }]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( _openKeyboard ) {
        [_textField becomeFirstResponder];
    }
    
    NSLog(@"willAppear %@", [UIResponder currentFirstResponder]);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"didAppear %@", [UIResponder currentFirstResponder]);
    
    for ( NSLayoutConstraint *constraint in self.view.superview.constraints ) {
        if ( constraint.firstItem == self.view && constraint.firstAttribute == NSLayoutAttributeHeight ) {
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"willDisappear %@", [UIResponder currentFirstResponder]);
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"didDisappear %@", [UIResponder currentFirstResponder]);
}


#pragma mark - uitextfieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textField.inputAccessoryView = self.view;
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _textField.inputAccessoryView = nil;
    return YES;
}


@end
