//
//  ViewController.m
//  CALayerAsyncDrawTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "TestView2.h"

@interface ViewController ()

@end

@implementation ViewController{
    TestView *_testView;
    
    TestView2 *_testView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // _testView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
   // _testView.backgroundColor = [UIColor lightGrayColor];
    //[self.view addSubview:_testView];
    
    _testView2 = [[TestView2 alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_testView2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
