//
//  ViewController.m
//  propertyAnimationTest
//
//  Created by rovaev on 22.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "FloatAnimator.h"

@interface ViewController ()<FloatAnimatorDelegate>

@end

@implementation ViewController
{
    FloatAnimator *animator;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    animator = [[FloatAnimator alloc] initWithFps:60];
    animator.delegate = self;
    [animator animateFrom:0 andTo:1 withDuration:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)floatAnimator:(FloatAnimator *)animator didChangeValue:(float)value
{
    NSLog(@"value = %f", value);
}


@end
