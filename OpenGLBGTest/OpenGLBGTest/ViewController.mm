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
@property (nonatomic, strong) CAEAGLLayer *mainLayer;
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic, strong) NSLock *renderLock;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) GLuint renderbuffer;
@property (nonatomic) GLuint framebuffer;
@property (nonatomic) EAGLSharegroup *sharegroup;
@property (nonatomic) NVGcontext *vg;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

@implementation ViewController {
    CGFloat xshift;
}

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
    [self render];
}


- (void)setup
{
    self.renderQueue = dispatch_queue_create("Render-Queue", DISPATCH_QUEUE_SERIAL);
    self.renderLock = [[NSLock alloc] init];
    
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.mainContext];
    
    self.mainLayer = [CAEAGLLayer new];
    self.mainLayer.frame = CGRectMake(0.0, 0.0, 100.0, 300.0);
    self.mainLayer.opaque = YES;
    self.mainLayer.contentsScale = [UIScreen mainScreen].scale;
    self.mainLayer.drawableProperties = @{
                                          kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
                                          };
    [self.view.layer addSublayer:self.mainLayer];
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.mainLayer];
    
    dispatch_async(self.renderQueue, ^{
        xshift = 0.0f;
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        _vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
    });
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.mainLayer.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    CGSize size = self.view.frame.size;
    dispatch_async(self.renderQueue, ^{
        self.width = size.width;
        self.height = size.height;
    });
}


- (void)render
{
    if ( [self.renderLock tryLock] ) {
        [self.renderLock unlock];
    }
    else {
        return;
    }
    
    dispatch_async(self.renderQueue, ^{
        [self.renderLock lock];
        [EAGLContext setCurrentContext:self.renderContext];
        
        glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        
        glViewport(0, 0, 300.0 *[UIScreen mainScreen].scale, 300.0 *[UIScreen mainScreen].scale);
        glClearColor(100.0 / 255.0, 10.0 / 255.0, 100.0 / 255.0, 0.0);
        glClear(GL_COLOR_BUFFER_BIT);
        
        nvgBeginFrame(_vg, 300.0, 300.0, [UIScreen mainScreen].scale);
        
        nvgStrokeColor(_vg, nvgRGB(255.0, 1.0, 1.0));
        nvgStrokeWidth(_vg, 0.5f);
        
        nvgBeginPath(_vg);
        nvgMoveTo(_vg, 0.0 + xshift, 0.0);
        nvgLineTo(_vg, 100.0 + xshift, 100.0);
        nvgStroke(_vg);
        
        nvgEndFrame(_vg);
        glFlush();
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        xshift += 0.1f;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
            [self.mainContext presentRenderbuffer:_renderbuffer];
            glFlush();
        });
        [self.renderLock unlock];
    });
}


@end
