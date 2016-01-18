//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotViewController.h"
#include "GraphInstance.h"
#import <OpenGLES/ES2/glext.h>

@interface PlotViewController ()
@end

@implementation PlotViewController {
    GraphInstance test;
    EAGLContext *_context;
}

- (void)loadView
{
    [super loadView];
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [self setupGL];
    
    GLKView *view = (GLKView *)self.view;
    view.context = _context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    
    self.preferredFramesPerSecond = 60;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:_context];
    
    test.width = self.view.frame.size.width;
    test.height = self.view.frame.size.height;
    test.scale = [[UIScreen mainScreen] scale];
    test.render();
}


- (void)testFunct
{
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:_context];
    test = GraphInstance();
    srand48(arc4random());
    
    double x = drand48();
    test.x =  x;
}


- (void)setRed:(BOOL)red
{
    test.red = red;
}


@end
