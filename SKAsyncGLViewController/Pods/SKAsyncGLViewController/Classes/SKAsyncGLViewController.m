//
//  SKAsyncGLViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SKAsyncGLViewController.h"
#import "RDRIntermediateTarget.h"

@interface SKAsyncGLViewController ()
@property (nonatomic) CADisplayLink *displayLink;
@end

@implementation SKAsyncGLViewController

- (void)loadView
{
    self.view = [SKAsyncGLView new];
    self.view.delegate = self;
}


- (void)removeFromParentViewController
{
    [super removeFromParentViewController];
    
    if ( self.displayLink ) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}


- (void)render
{
    [self.view render];
}


#pragma mark - SKAsyncGLViewDelegate

- (void)createBuffersForView:(SKAsyncGLView *)asyncView
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


- (void)removeBuffersForView:(SKAsyncGLView *)asyncView
{
    if ( [_delegate respondsToSelector:@selector(removeBuffers:)] ) {
        [_delegate removeBuffers:self];
    }
}


- (void)drawInRect:(CGRect)rect
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}


@end
