//
//  ViewController.m
//  NanoVg_test
//
//  Created by Stephen Kopylov - Home on 18/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "PlotView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PlotView *view = [[PlotView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
