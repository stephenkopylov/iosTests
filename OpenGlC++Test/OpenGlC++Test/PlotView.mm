//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotView.h"
#include "GraphInstance.h"



@implementation PlotView {
    GraphInstance test;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        test = GraphInstance();
        test.test();
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        [EAGLContext setCurrentContext:context];
        GLKView *view = [[GLKView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.context = context;
        view.backgroundColor = [UIColor redColor];
        view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        view.delegate = self;
        view.enableSetNeedsDisplay = YES;
        [self addSubview:view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view setNeedsDisplay];
        });
    }
    
    return self;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    test.test2();
}


@end
