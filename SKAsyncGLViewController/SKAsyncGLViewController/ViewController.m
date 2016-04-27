//
//  ViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import "SampleViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSInteger _num;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)buttonTapped:(id)sender
{
    SampleViewController *vc = [SampleViewController new];
    
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    
    vc.view.frame = CGRectMake(0 + 20 * _num, 0 + 20 * _num, 100, 100);
    
    [self.view addSubview:vc.view];
    
    _num++;
}


@end
