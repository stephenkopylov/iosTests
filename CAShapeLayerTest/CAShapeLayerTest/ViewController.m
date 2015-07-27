//
//  ViewController.m
//  CAShapeLayerTest
//
//  Created by rovaev on 27/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"
#import "testView.h"

@interface ViewController ()

@end

@implementation ViewController{
    ShapeView *_view;
    UIScrollView *_scrollView;
    testView *_testView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    _view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_view];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        _view.frame = CGRectMake(0, 0, 300, 300);
    }];
    _scrollView = [UIScrollView new];
    _scrollView.frame = self.view.frame;
    _scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_scrollView];
    
    _testView = [testView new];
    _testView.backgroundColor = [UIColor lightGrayColor];
    _testView.frame = CGRectMake(0, 0, 1000, 1000);
    [_scrollView addSubview:_testView];
    
    _scrollView.contentSize = _testView.frame.size;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //CGAffineTransform transform = CGAffineTransformMakeScale(0.2, 0.2);
        //_testView.transform = transform;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
