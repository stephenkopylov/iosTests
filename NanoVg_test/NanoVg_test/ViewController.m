//
//  ViewController.m
//  NanoVg_test
//
//  Created by Stephen Kopylov - Home on 18/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "PlotViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PlotViewController *plot = [PlotViewController new];
    [self addChildViewController:plot];
    [plot didMoveToParentViewController:self];
    plot.view.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:plot.view];
    
    PlotViewController *plot2 = [PlotViewController new];
    [self addChildViewController:plot2];
    [plot2 didMoveToParentViewController:self];
    plot2.view.frame = CGRectMake(0, 220, 200, 200);
    [self.view addSubview:plot2.view];
    plot2.red = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
