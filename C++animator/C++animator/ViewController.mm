//
//  ViewController.m
//  C++animator
//
//  Created by Stephen Kopylov - Home on 20/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#include "PlotAnimator.h"

@interface ViewController ()

@property (nonatomic) CADisplayLink *displayLink;

@property (nonatomic) PlotAnimator plotAnimator;

@end

@implementation ViewController {
    double _val;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _plotAnimator = PlotAnimator();
    _plotAnimator.duration = 1.0;
    
    // Do any additional setup after loading the view, typically from a nib.
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEmitted)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)click:(id)sender
{
    _val -= 0.0009;
    NSLog(@"setting new value = %f", _val);
    NSLog(@"from value = %f", _plotAnimator.fromValue);
    //_plotAnimator.fromValue = 100.0;
    _plotAnimator.setToValue(_val);
}


- (void)displayLinkEmitted
{
    _plotAnimator.time = CACurrentMediaTime();
    
    NSLog(@"test = %f", _plotAnimator.getValue());
}


@end
