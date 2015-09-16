//
//  ViewController.m
//  OGLTest
//
//  Created by Stephen Kopylov - Home on 16.09.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[OpenGLView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
