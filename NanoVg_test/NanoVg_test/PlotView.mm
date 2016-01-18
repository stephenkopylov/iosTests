//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotView.h"
#include "GraphInstance.h"
#import <OpenGLES/ES2/glext.h>

@interface PlotView ()
@end

@implementation PlotView {
    GraphInstance test;
    EAGLContext *_context;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        self.context = _context;
        [self setupGL];
        self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        self.delegate = self;
        self.enableSetNeedsDisplay = YES;
    }
    
    return self;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:self.context];
    
    test.width = self.frame.size.width;
    test.height = self.frame.size.height;
    test.scale = [[UIScreen mainScreen] scale];
    test.render();
}


- (void)testFunct
{
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    test = GraphInstance();
    
    srand48(arc4random());
    
    double x = drand48();
    test.x =  x;
}


@end
