//
//  SKAsyncGLViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SKAsyncGLViewController.h"

@interface SKAsyncGLViewController ()<SKAsyncGLViewDelegate>

@end

@implementation SKAsyncGLViewController

- (void)loadView
{
    self.view = [SKAsyncGLView new];
    self.view.delegate = self;
}


#pragma mark - SKAsyncGLViewDelegate

- (void)createBuffers:(SKAsyncGLView *)asyncView
{
    if ( [_delegate respondsToSelector:@selector(createBuffers:)] ) {
        [_delegate createBuffers:self];
    }
}


@end
