//
//  ViewController.m
//  PullableViewRefactoring
//
//  Created by Stephen Kopylov - Home on 23/02/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "PullableView.h"

@interface ViewController ()

@property (nonatomic) PullableView *pullableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _pullableView = [PullableView new];
    [self.view addSubview:_pullableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
