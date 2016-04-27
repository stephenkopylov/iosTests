//
//  ViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SKAsyncGLViewControllerDelegate>

@end

@implementation ViewController

- (void)loadView
{
    self.delegate = self;
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - SKAsyncGLViewControllerDelegate

- (void)createBuffers:(SKAsyncGLViewController *)viewController
{
}


@end
