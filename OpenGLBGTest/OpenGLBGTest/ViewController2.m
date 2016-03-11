//
//  ViewController2.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController2.h"
#import "GCDGLView.h"
#define NANOVG_GLES2_IMPLEMENTATION
#import <OpenGLES/ES2/glext.h>
#include "nvg/nanovg.h"
#include "nvg/nanovg_gl.h"
#include "nvg/nanovg_gl_utils.h"

@interface ViewController2 ()<GCDGLViewDelegate>

@property (nonatomic) CGFloat xshift;
@property (nonatomic) NVGcontext *vg;

@end

@implementation ViewController2
{
    GCDGLView *_glView;
}

- (void)loadView
{
    [super loadView];
    
    _glView = [GCDGLView new];
    _glView.delegate = self;
    _glView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_glView];
    
    NSDictionary *views = @{
                            @"glView": _glView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[glView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[glView]|" options:0 metrics:nil views:views]];
}


- (void)setupGL:(GCDGLView *)view
{
    _vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
    _xshift = 0.0;
}


- (void)drawInRect:(CGRect)rect forView:(GCDGLView *)view
{
    nvgBeginFrame(_vg,  rect.size.width, rect.size.height, [UIScreen mainScreen].scale);
    
    nvgStrokeColor(_vg, nvgRGB(0.0, 0.0, 0.0));
    nvgStrokeWidth(_vg, 1.f);
    
    nvgBeginPath(_vg);
    nvgMoveTo(_vg, 0.0 + _xshift, 0.0);
    nvgLineTo(_vg, 100.0 + _xshift, 100.0);
    nvgStroke(_vg);
    
    nvgBeginPath(_vg);
    nvgStrokeColor(_vg, nvgRGB(0.0, 0.0, 8.0));
    nvgMoveTo(_vg, 0.0, 0.0);
    nvgLineTo(_vg, 30.0 + _xshift, 1000.0);
    nvgStroke(_vg);
    
    nvgEndFrame(_vg);
    
    //_xshift += 0.5;
}


@end
