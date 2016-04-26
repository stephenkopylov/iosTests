//
//  GCNGLView.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//
#define NANOVG_GLES2_IMPLEMENTATION
#import "GCDGLView.h"
#include <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <RDRIntermediateTarget.h>
#import "nanovg/nanovg.c"
#import "nanovg/nanovg.h"
#import "nanovg/nanovg_gl.h"
#import "nanovg/nanovg_gl_utils.h"

@interface GCDGLView ()
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic) CADisplayLink *displayLink;

@property (nonatomic) GLuint framebuffer;
@property (nonatomic) GLuint stencilbuffer;
@property (nonatomic) GLuint renderbuffer;

@property (nonatomic) GLuint sampleframebuffer;
@property (nonatomic) GLuint samplestencilbuffer;
@property (nonatomic) GLuint samplerenderbuffer;

@property (nonatomic) CGFloat scale;

@property (nonatomic) BOOL renderable;

@property (nonatomic) BOOL rendering;

@property (nonatomic)  NVGcontext *vg;

@end

@implementation GCDGLView {
    UIButton *_closeButton;
}

+(void)load{
    
}

- (instancetype)initWithRenderQueue:(dispatch_queue_t)renderQueue
{
    self = [super init];
    
    if ( self ) {
        self.renderQueue = renderQueue;
        [self setup];
    }
    
    return self;
}


- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        self.renderQueue = dispatch_queue_create("Render-Queue", DISPATCH_QUEUE_SERIAL);
        
        [self setup];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0, 0, 30, 30);
        _closeButton.backgroundColor = [UIColor lightGrayColor];
        [_closeButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    
    return self;
}


- (void)buttonTapped
{
    [self removeFromSuperview];
}


- (void)dealloc
{
    NSLog(@"dealloc %@", self);
}


+ (Class)layerClass
{
    return [CAEAGLLayer class];
}


- (void)setup
{
    self.scale = [UIScreen mainScreen].scale;
    
    ((CAEAGLLayer *)self.layer).opaque = NO;
    ((CAEAGLLayer *)self.layer).contentsScale = _scale;
    
    [self createBuffers];
}


- (void)createBuffers
{
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.mainContext];
    
    CGFloat width = 10.f;
    CGFloat height = 10.f;
    
    glViewport(0, 0, width, height);
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    
    dispatch_async(self.renderQueue, ^{
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        GLint samples;
        glGetIntegerv(GL_MAX_SAMPLES_APPLE, &samples);
        
        glViewport(0, 0, width, height);
        
        glGenRenderbuffers(1, &_stencilbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, width, height);
        
        glGenFramebuffers(1, &_framebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
        
        //----multisampling
        
        glGenRenderbuffers(1, &_samplerenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_RGBA8_OES, width, height);
        
        glGenRenderbuffers(1, &_samplestencilbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_DEPTH24_STENCIL8_OES, width, height);
        
        glGenFramebuffers(1, &_sampleframebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _samplerenderbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
        
        GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        
        if ( status == GL_FRAMEBUFFER_COMPLETE ) {
            NSLog(@"framebuffer complete");
        }
        else if ( status == GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT ) {
            NSLog(@"incomplete framebuffer attachments");
        }
        else if ( status == GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT ) {
            NSLog(@"incomplete missing framebuffer attachments");
        }
        else if ( status == GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS ) {
            NSLog(@"incomplete framebuffer attachments dimensions");
        }
        else if ( status == GL_FRAMEBUFFER_UNSUPPORTED ) {
            NSLog(@"combination of internal formats used by attachments in thef ramebuffer results in a nonrednerable target");
        }
        
        if ( [self.delegate respondsToSelector:@selector(setupGL:)] ) {
            [self.delegate setupGL:self];
        }
        
        self.vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            RDRIntermediateTarget *target = [RDRIntermediateTarget intermediateTargetWithTarget:self];
            self.displayLink = [CADisplayLink displayLinkWithTarget:target selector:@selector(render)];
            [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        });
    });
}


//- (void)removeBuffers
//{
//
//    dispatch_async(self.renderQueue, ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
}


- (void)removeFromSuperview
{
    if ( _displayLink ) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    dispatch_async(self.renderQueue, ^{
        NSLog(@"removeFromSuperviewBackgroud %@", self);
        
        glFinish();
        nvgDeleteGLES2(self.vg);
        
        //        [self removeBuffers];
        
        if ( _framebuffer != 0 ) {
            glDeleteFramebuffers(1, &_framebuffer);
            _framebuffer =  0;
        }
        
        if ( _stencilbuffer != 0 ) {
            glDeleteRenderbuffers(1, &_stencilbuffer);
            _stencilbuffer =  0;
        }
        
        if ( _sampleframebuffer != 0 ) {
            glDeleteFramebuffers(1, &_sampleframebuffer);
            _sampleframebuffer =  0;
        }
        
        if ( _samplestencilbuffer != 0 ) {
            glDeleteRenderbuffers(1, &_samplestencilbuffer);
            _samplestencilbuffer =  0;
        }
        
        if ( _samplerenderbuffer != 0 ) {
            glDeleteRenderbuffers(1, &_samplerenderbuffer);
            _samplerenderbuffer =  0;
        }
        
        if ( [EAGLContext currentContext] == _renderContext ) {
            [EAGLContext setCurrentContext:nil];
        }
        
        _renderContext = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"removeFromSuperview %@", self);
            
            if ( _renderbuffer != 0 ) {
                glDeleteRenderbuffers(1, &_renderbuffer);
                _renderbuffer =  0;
            }
            
            if ( [EAGLContext currentContext] == _mainContext ) {
                [EAGLContext setCurrentContext:nil];
            }
            
            _mainContext = nil;
            
            [super removeFromSuperview];
        });
    });
}


- (void)render
{
    if ( !self.renderable ) {
        return;
    }
    
    @synchronized(self) {
        if ( _rendering ) {
            return;
        }
    }
    
    CGFloat width = self.frame.size.width * _scale;
    CGFloat height = self.frame.size.height * _scale;
    
    dispatch_async(self.renderQueue, ^{
        if ( !self.renderable ) {
            return;
        }
        
        @synchronized(self) {
            _rendering = YES;
        }
        
        [EAGLContext setCurrentContext:self.renderContext];
        glViewport(0, 0, width, height);
        
        
        glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, width, height);
        GLint samples;
        glGetIntegerv(GL_MAX_SAMPLES_APPLE, &samples);
        
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_RGBA8_OES, width, height);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_DEPTH24_STENCIL8_OES, width, height);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
        
        glClearColor(0.f, 0.f, 1.0f, 1.0f);
        //        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
        
        int randNum = rand() % (255 - 0) + 0;
        int randNum2 = rand() % (5 - 0) + 0;
        
        nvgBeginFrame(self.vg, roundf(self.frame.size.width), roundf(self.frame.size.height), [UIScreen mainScreen].scale);
        nvgStrokeColor(self.vg, nvgRGB(randNum, 0, 0));
        nvgStrokeWidth(self.vg, randNum2);
        nvgBeginPath(self.vg);
        nvgMoveTo(self.vg, 0.0, 0.0);
        nvgLineTo(self.vg, 100.0, 100.0);
        nvgStroke(self.vg);
        nvgEndFrame(self.vg);
        
        glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, _sampleframebuffer);
        glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, _framebuffer);
        glResolveMultisampleFramebufferAPPLE();
        
        const GLenum discards[]  = { GL_COLOR_ATTACHMENT0, GL_DEPTH_ATTACHMENT };
        glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE, 2, discards);
        glFinish();
        
        if ( !self.renderable ) {
            return;
        }
        
        glFlush();
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ( !self.renderable ) {
                return;
            }
            
            [EAGLContext setCurrentContext:self.mainContext];
            
            glViewport(0, 0, width, height);
            
            [self.mainContext presentRenderbuffer:_renderbuffer];
            glFlush();
        });
        @synchronized(self) {
            _rendering = NO;
        }
    });
}


- (BOOL)renderable
{
    if ( self.frame.size.width == 0.0f || self.frame.size.height == 0.0f || self.isHidden || [UIApplication sharedApplication].applicationState != UIApplicationStateActive || !self.superview || self.layer.frame.size.width == 0.0f || self.layer.frame.size.height == 0.0f ) {
        @synchronized(self) {
            _rendering = NO;
        }
        return NO;
    }
    
    return YES;
}


@end
