//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotView.h"
#include "GraphInstance.h"
#include <OpenGLES/ES1/gl.h>

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
        test = GraphInstance();
        
        srand48(arc4random());
        
        double x = drand48();
        test.x =  x;
        
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        self.context = _context;
        self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        self.delegate = self;
        self.enableSetNeedsDisplay = YES;
    }
    
    return self;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:_context];
    glClear(GL_COLOR_BUFFER_BIT);
}


- (void)testFunct
{
}


@end
