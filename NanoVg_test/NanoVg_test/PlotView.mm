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
#include "nanovg.h"
#define NANOVG_GLES2_IMPLEMENTATION
#include "nanovg_gl.h"
#include "nanovg_gl_utils.h"

@interface PlotView ()
@end

@implementation PlotView {
    GraphInstance test;
    EAGLContext *_context;
    NVGcontext *vg;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        test = GraphInstance();
        
        srand48(arc4random());
        
        double x = drand48();
        test.x =  x;
        
        
        
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
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_CULL_FACE);
    glDisable(GL_DEPTH_TEST);
    
    int winWidth = self.frame.size.width;
    int winHeight = self.frame.size.height;
    float mx = 0; // mouse x and y
    float my = 0;
    int blowup = 0;
    
    
    nvgBeginFrame(vg, winWidth, winHeight, [[UIScreen mainScreen] scale]);
    
    //renderGraph(vg, 5,5, &fps);
    
    nvgEndFrame(vg);
}


- (void)testFunct
{
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
    assert(vg);
}


@end
