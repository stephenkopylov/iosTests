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
    
    self.mainLayer = [CAEAGLLayer new];
    self.mainLayer.frame = CGRectMake(0.0, 0.0, 300.0, 300.0);
    self.mainLayer.opaque = YES;
    self.mainLayer.contentsScale = 1.0;
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
    
    _vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
    
    dispatch_async(self.renderQueue, ^{
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        _renderLayer = [CAEAGLLayer new];
        _renderLayer.frame = CGRectMake(0.0, 0.0, 100., 100.0);
        _renderLayer.opaque = YES;
        _renderLayer.contentsScale = 1.0;
        _renderLayer.drawableProperties = @{
                                            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
                                            };
        
        
        [EAGLContext setCurrentContext:self.renderContext];
        
        [self.renderContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_renderLayer];
    });
}


- (void)render:(BOOL)force
{
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        
   
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
         
            glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
            glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
            
            glViewport(0, 0, 300, 300);
            glClearColor(10.0 / 255.0, 10.0 / 255.0, 100.0 / 255.0, 0.0);
            glClear(GL_COLOR_BUFFER_BIT);
            
            nvgBeginFrame(_vg, 300.0, 300.0, 1.0);
            
            nvgStrokeColor(_vg, nvgRGB(255.0, 1.0, 1.0));
            nvgStrokeWidth(_vg, 1.5f);
            
            nvgBeginPath(_vg);
            nvgMoveTo(_vg, 0.0, 0.0);
            nvgLineTo(_vg, 100.0, 100.0);
            nvgStroke(_vg);
            
            nvgEndFrame(_vg);
            
            [self.mainContext presentRenderbuffer:GL_RENDERBUFFER];
            
            glBindRenderbuffer(GL_RENDERBUFFER, 0);
            glBindFramebuffer(GL_FRAMEBUFFER, 0);
        });
    });
}


@end
