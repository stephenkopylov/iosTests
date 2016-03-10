//
//  ViewController.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 10/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#define NANOVG_GLES2_IMPLEMENTATION
#import <OpenGLES/ES2/glext.h>
#include "nvg/nanovg.h"
#include "nvg/nanovg_gl.h"
#include "nvg/nanovg_gl_utils.h"
#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) CAEAGLLayer *renderLayer;
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic, strong) NSLock *renderLock;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) GLuint colorRenderBuffer;
@property (nonatomic) GLuint frameBuffer;
@property (nonatomic) EAGLSharegroup *sharegroup;
@property (nonatomic) NVGcontext *vg;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refresh)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)refresh
{
    [self render:NO];
}


- (void)setup
{
    self.renderQueue = dispatch_queue_create("Render-Queue", DISPATCH_QUEUE_SERIAL);
    
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.mainContext];
    GLKView *view = (GLKView *)self.view;
    view.context = self.mainContext;
    
    
    dispatch_async(self.renderQueue, ^{
        _renderLayer = [CAEAGLLayer new];
        _renderLayer.frame = CGRectMake(0.0, 0.0, 100., 100.0);
        _renderLayer.opaque = YES;
        _renderLayer.contentsScale = 1.0;
        _renderLayer.drawableProperties = @{
                                            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
                                            };
        
        
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        glGenRenderbuffers(1, &_colorRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
        [self.renderContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_renderLayer];
        
        glGenFramebuffers(1, &_frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
        
        _vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
    });
}


- (void)render:(BOOL)force
{
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        
        glViewport(0, 0, 100.0, 100.0);
        glClearColor(10.0, 104.0 / 255.0, 55.0 / 255.0, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);
        
        
        glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
        
        
        [self.renderContext presentRenderbuffer:GL_RENDERBUFFER];
        
        nvgBeginFrame(_vg, 100.0, 100.0, 2.0);
        
        nvgStrokeColor(_vg, nvgRGB(1.0, 0.5, 1.0));
        nvgStrokeWidth(_vg, 1.5f);
        
        nvgBeginPath(_vg);
        nvgMoveTo(_vg, 0.0, 0.0);
        nvgLineTo(_vg, 100.0, 100.0);
        nvgStroke(_vg);
        
        nvgEndFrame(_vg);
        glFlush();
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
            
            glClearColor(10.0 / 255.0, 10.0 / 255.0, 100.0 / 255.0, 0.0);
            glClear(GL_COLOR_BUFFER_BIT);
            
            [self.mainContext presentRenderbuffer:GL_RENDERBUFFER];
        });
    });
}


@end
