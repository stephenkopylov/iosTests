//
//  TestViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 27/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "TestViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "CustomDisplayNode.h"

@interface TestViewController ()
@property (nonatomic) CustomDisplayNode *node;
@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _node = [CustomDisplayNode new];
    
    [self.view addSubview:_node.view];
    _node.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{
                            @"nodeView": _node.view
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[nodeView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nodeView]|" options:0 metrics:nil views:views]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_node measure:self.view.frame.size];
}


@end
