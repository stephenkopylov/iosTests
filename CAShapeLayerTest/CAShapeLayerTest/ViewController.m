//
//  ViewController.m
//  CAShapeLayerTest
//
//  Created by rovaev on 27/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"

@interface ViewController ()

@end

@implementation ViewController{
    ShapeView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    _view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_view];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
