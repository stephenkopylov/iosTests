//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotViewController.h"
#include "Plot.h"
#import <OpenGLES/ES2/glext.h>
#import "PlotPoint.h"

@interface PlotViewController ()
@end

@implementation PlotViewController {
    Plot *plot;
    EAGLContext *_context;
}

#pragma mark - lifecycle

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


- (void)viewDidAppear:(BOOL)animated
{
    self.paused = NO;
}


#pragma mark - public methods

- (void)addPoints:(NSArray *)points
{
    int lenght = (int)points.count;
    double values[lenght];
    double times[lenght];
    
    
    for ( int i = 0; i < lenght; i++ ) {
        PlotPoint *point = points[i];
        
        values[i] = point.value.doubleValue;
        times[i] = point.time.doubleValue;
    }
    
    plot->addPoints(values, times, lenght);
}


#pragma mark - private methods

- (void)setupGL
{
    [EAGLContext setCurrentContext:_context];
    plot = new Plot();
}


#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:_context];
    
    plot->width = self.view.frame.size.width;
    plot->height = self.view.frame.size.height;
    plot->scale = [[UIScreen mainScreen] scale];
    plot->render();
}


@end
