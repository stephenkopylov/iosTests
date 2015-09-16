//
//  ViewController.m
//  ScrollViewZoomTest
//
//  Created by Stephen Kopylov - Home on 23.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController {
    UIView *_testView;
    UIView *_secondView;
    
    CGFloat lastScale;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _testView.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:_testView];
    
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    _secondView.backgroundColor = [UIColor greenColor];
    
    
    [self.scrollView addSubview:_secondView];
    
    [self.scrollView.pinchGestureRecognizer setEnabled:NO];
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.scrollView addGestureRecognizer:recognizer];
}


- (void)pinch:(UIPinchGestureRecognizer *)sender
{
    float x = [sender locationInView:self.scrollView].x - [sender locationOfTouch:1 inView:self.scrollView].x;
    
    NSLog(@"lastScale = %f", x);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
}


@end
