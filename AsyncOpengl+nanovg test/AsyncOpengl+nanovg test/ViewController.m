//
//  ViewController.m
//  AsyncOpengl+nanovg test
//
//  Created by Stephen Kopylov - Home on 26/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import "GCDGLView.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSInteger num;
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


- (IBAction)buttonTapped:(id)sender
{
    GCDGLView *view = [GCDGLView new];
    
    view.frame = CGRectMake(0+10*num, 100+10*num, 100, 100);
    [self.view addSubview:view];
    
    num++;
}


@end
