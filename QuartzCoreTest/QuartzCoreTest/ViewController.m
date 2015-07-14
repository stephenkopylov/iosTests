//
//  ViewController.m
//  QuartzCoreTest
//
//  Created by rovaev on 14.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "GraphView.h"

@interface ViewController () <UIScrollViewDelegate>

@end

#define GRAPH_STEP 20

@implementation ViewController {
    GraphView *_graphView;
    NSArray *_data;
    UIScrollView *_scrollView;
    UIView *_fakeView;
}

- (void)loadView
{
    [super loadView];
    
    _data = @[ @0.7, @0.4, @0.9, @1.0, @0.2, @0.85, @0.11, @0.75, @0.53, @0.44, @0.88, @0.77, @0.99, @0.55, @0.4, @0.9, @1.0, @0.2, @0.85, @0.11, @0.75, @0.53, @0.44, @0.88, @0.77, @0.99, @0.55, @0.4, @0.9, @1.0, @0.2, @0.85, @0.11, @0.75, @0.53, @0.44, @0.88, @0.77, @0.99, @0.55 ];
    
    _graphView = [[GraphView alloc] initWithFrame:self.view.bounds];
    _graphView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_graphView];
    
    _fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _data.count*GRAPH_STEP, self.view.bounds.size.height)];
    _fakeView.backgroundColor = [UIColor yellowColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor greenColor];
    _scrollView.delegate = self;
    //[_scrollView addSubview:_fakeView];
    
    _scrollView.contentSize = CGSizeMake(_data.count*GRAPH_STEP, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
}

-(NSArray*)getWindow{
    NSInteger startIndex = ceil(_scrollView.contentOffset.x/GRAPH_STEP);
    NSLog(@"%d",startIndex);
    return nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self getWindow];
}


@end
