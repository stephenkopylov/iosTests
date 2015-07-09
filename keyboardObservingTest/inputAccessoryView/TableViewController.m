//
//  TableViewController.m
//  inputAccessoryView
//
//  Created by Admin on 04.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "TableViewController.h"
#import "UIResponder+FirstResponder.h"
#import "PushViewController.h"
#import "ModalViewController.h"
#import "TextField.h"

static BOOL openKeyboard;

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@end


static void *__keyboardCenterKVOContext = &__keyboardCenterKVOContext;

@implementation TableViewController {
    UITableView *_tableView;
    UIView *_testAccessoryView;
    TextField *_textField;
    UIView *_testView;
    NSMutableArray *_accViewConstraints;
    NSLayoutConstraint *_bottomConstraint;
}


+ (void)load
{
    openKeyboard = NO;
}


- (void)loadView
{
    [super loadView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    UIBarButtonItem *firstItem = [[UIBarButtonItem alloc] initWithTitle:@"Alert" style:UIBarButtonItemStylePlain target:self action:@selector(alert)];
    UIBarButtonItem *secondItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    UIBarButtonItem *thirdItem = [[UIBarButtonItem alloc] initWithTitle:@"Modal" style:UIBarButtonItemStylePlain target:self action:@selector(modal)];
    self.navigationItem.rightBarButtonItems = @[firstItem, secondItem, thirdItem];
    
    _tableView = [UITableView new];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _testAccessoryView = [UIView new];
    _testAccessoryView.backgroundColor = [UIColor redColor];
    _testAccessoryView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(100, -100, 100, 100)];
    _testView.backgroundColor = [UIColor redColor];
    
    UITextField *test = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_testView addSubview:test];
    
    
    _textField = [TextField new];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.borderColor = [UIColor grayColor].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tv]|" options:0 metrics:nil views:@{ @"tv": _tableView }]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv]|" options:0 metrics:nil views:@{ @"tv": _tableView }]];
    
    [_testAccessoryView addSubview:_textField];
    [_testAccessoryView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[textField]-10-|" options:0 metrics:nil views:@{ @"textField": _textField }]];
    [_testAccessoryView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField]-10-|" options:0 metrics:nil views:@{ @"textField": _textField }]];
    
    [self addViewToVC];
}


- (void)addViewToVC
{
    [_testAccessoryView removeFromSuperview];
    [self.view addSubview:_testAccessoryView];
    
    [self addConstraints:self.view isKeyboard:NO];
}


- (void)addConstraints:(UIView *)view isKeyboard:(BOOL)isKeyboard
{
    if ( _accViewConstraints.count ) {
        [_testAccessoryView.superview removeConstraints:_accViewConstraints.copy];
    }
    
    _accViewConstraints = [NSMutableArray new];
    [_accViewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[accView]|" options:0 metrics:nil views:@{ @"accView": _testAccessoryView }]];
    _bottomConstraint = [NSLayoutConstraint constraintWithItem:_testAccessoryView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [_accViewConstraints addObject:_bottomConstraint];
    
    [_accViewConstraints addObject:[NSLayoutConstraint constraintWithItem:_testAccessoryView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:40]];
    
    [view addConstraints:_accViewConstraints.copy];
}


- (void)addViewToKeyboard
{
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView *keyboard;
    
    for ( int i = 0; i < [tempWindow.subviews count]; i++ ) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard found, add the button
        
        if ( [[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES ) {
        }//This code will work on iOS 8.0
        else if ( [[keyboard description] hasPrefix:@"<UIInputSetContainerView"] == YES ) {
            for ( int i = 0; i < [keyboard.subviews count]; i++ ) {
                UIView *hostkeyboard = [keyboard.subviews objectAtIndex:i];
                
                if ( [[hostkeyboard description] hasPrefix:@"<UIInputSetHost"] == YES ) {
                    //[self addViewToKeyboard:hostkeyboard];
                    [self startObserving:hostkeyboard];
                }
            }
        }
    }
}


- (void)startObserving:(UIView *)view
{
    [view addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:__keyboardCenterKVOContext ];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( context == __keyboardCenterKVOContext ) {
        CGPoint newKeyboardCenter = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        UIView *keyboardView = (UIView*)object;
        NSLog(@"y = %f",newKeyboardCenter.y);
        _bottomConstraint.constant = -(self.view.frame.size.height - keyboardView.frame.origin.y);
    }
    else {
        [ super observeValueForKeyPath:keyPath ofObject:object change:change context:context ];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"didAppear %@", [UIResponder currentFirstResponder]);
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark - custom methods

- (void)alert
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"test" message:@"test-test-test" preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"test" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)push
{
    [self.navigationController pushViewController:[PushViewController new] animated:YES];
}


- (void)modal
{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[ModalViewController new]] animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


#pragma mark - TextFieldDelegate



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self addViewToKeyboard];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self addViewToVC];
    return YES;
}


@end
