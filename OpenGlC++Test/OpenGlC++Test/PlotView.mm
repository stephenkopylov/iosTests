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
        GLKView *view = [[GLKView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.context = _context;
        view.backgroundColor = [UIColor redColor];
        view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        view.delegate = self;
        view.enableSetNeedsDisplay = YES;
        [self addSubview:view];
    }
    
    return self;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:_context];
    glClear(GL_COLOR_BUFFER_BIT);
    
    //ортодоксальная проекция, збс штука - делить вьюпорт на сегменты

    
     [EAGLContext setCurrentContext:_context];
     test.test();
     test.test2();
     
}


@end
