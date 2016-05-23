//
//  ViewController.m
//  ButtonsTest
//
//  Created by Stephen Kopylov - Home on 23/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    button.tintColor = [UIColor redColor];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"test" forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0f, 0.0f, 150.0f, 60.0f);
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
