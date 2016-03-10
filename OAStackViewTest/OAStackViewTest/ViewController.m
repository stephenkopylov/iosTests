//
//  ViewController.m
//  OAStackViewTest
//
//  Created by Stephen Kopylov - Home on 05/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import <OAStackView.h>
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestView *view1 = [TestView new];
    //view1.label.text = @"123123123123";
    view1.backgroundColor = [UIColor redColor];
    /*
     [view1.label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
     [view1.label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
     
     [view1.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
     [view1.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
     */
    
    NSLayoutConstraint *contraint = [NSLayoutConstraint constraintWithItem:view1.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:1.0 constant:10.0];
    contraint.priority = UILayoutPriorityRequired;
    [view1.label addConstraint:contraint];
    
    TestView *view2 = [TestView new];
    view2.backgroundColor = [UIColor greenColor];
    
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:view2.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:1.0 constant:10.0];
    contraint1.priority = UILayoutPriorityDefaultHigh;
    [view2.label addConstraint:contraint1];
    
    //view1.label.text = view2.label.text = @"123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123 123123123123";
    
    OAStackView *stackView = [[OAStackView alloc] initWithArrangedSubviews:@[view1, view2]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:stackView];
    
    NSDictionary *views = @{
                            @"stackView": stackView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[stackView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stackView]|" options:0 metrics:nil views:views]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
