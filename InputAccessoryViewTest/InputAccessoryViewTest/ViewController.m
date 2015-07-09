//
//  ViewController.m
//  InputAccessoryViewTest
//
//  Created by rovaev on 17.04.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "InputAccessoryViewViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [test setTitle:@"TEST" forState:UIControlStateNormal];
    [test setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clicked
{
    InputAccessoryViewViewController *vc = [InputAccessoryViewViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
