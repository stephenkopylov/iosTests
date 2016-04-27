//
//  SKAsyncGLViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SKAsyncGLViewController.h"
#import <RDRIntermediateTarget.h>

@interface SKAsyncGLViewController ()<SKAsyncGLViewDelegate>
@property (nonatomic) CADisplayLink *displayLink;
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RDRIntermediateTarget *target = [RDRIntermediateTarget intermediateTargetWithTarget:self];
        self.displayLink = [CADisplayLink displayLinkWithTarget:target selector:@selector(render)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    });
}


@end
