//
//  GCNGLView.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//
#import "GCDGLView.h"
#import <OpenGLES/ES2/glext.h>
#include <OpenGLES/ES2/gl.h>

@interface GCDGLView ()
//@property (nonatomic, strong) CAEAGLLayer *mainLayer;
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic, strong) NSLock *renderLock;
@property (nonatomic) CADisplayLink *displayLink;

@property (nonatomic) GLuint framebuffer;
@property (nonatomic) GLuint stencilbuffer;
@property (nonatomic) GLuint renderbuffer;

@property (nonatomic) GLuint sampleframebuffer;
@property (nonatomic) GLuint samplestencilbuffer;
@property (nonatomic) GLuint samplerenderbuffer;

@property (nonatomic) CGFloat scale;
@end

@implementation GCDGLView

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
    }
    
    return self;
}


+ (Class)layerClass
{
    return [CAEAGLLayer class];
}


- (void)setup
{
    self.scale = [UIScreen mainScreen].scale;
    
    self.renderLock = [[NSLock alloc] init];
    
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.mainContext];
    
    ((CAEAGLLayer *)self.layer).opaque = NO;
    ((CAEAGLLayer *)self.layer).contentsScale = _scale;
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    
    glGenRenderbuffers(1, &_stencilbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
    
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    
    //----multisampling
    
    glGenRenderbuffers(1, &_samplerenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
    
    glGenRenderbuffers(1, &_samplestencilbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
    
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
    
    dispatch_async(self.renderQueue, ^{
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        if ( [self.delegate respondsToSelector:@selector(setupGL:)] ) {
            [self.delegate setupGL:self];
        }
    });
    
    if ( self.displayLink ) {
        [self.displayLink invalidate];
    }
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    [EAGLContext setCurrentContext:self.mainContext];
    
    CGFloat width = self.frame.size.width * _scale;
    CGFloat height = self.frame.size.height * _scale;
    
    glViewport(0, 0, width, height);
    
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
    
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        glViewport(0, 0, width, height);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, width, height);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_RGBA8_OES, width, height);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_DEPTH24_STENCIL8_OES, width, height);
    });
}


- (void)render
{
    if ( self.frame.size.width == 0 || self.frame.size.height == 0 || self.isHidden || [UIApplication sharedApplication].applicationState != UIApplicationStateActive ) {
        return;
    }
    
    if ( [self.renderLock tryLock] ) {
        [self.renderLock unlock];
    }
    else {
        return;
    }
    
    dispatch_async(self.renderQueue, ^{
        [self.renderLock lock];
        [EAGLContext setCurrentContext:self.renderContext];
        
        glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
        
        
        glClearColor(0.f, 0.f, 0.5f, 0.3);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        if ( [self.delegate respondsToSelector:@selector(drawInRect:forView:)] ) {
            [self.delegate drawInRect:self.frame forView:self];
        }
        
        glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, _sampleframebuffer);
        glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, _framebuffer);
        glResolveMultisampleFramebufferAPPLE();
        
        const GLenum discards[]  = { GL_COLOR_ATTACHMENT0, GL_DEPTH_ATTACHMENT };
        glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE, 2, discards);
        
        glFlush();
        dispatch_async(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
            
            [self.mainContext presentRenderbuffer:_renderbuffer];
            glFlush();
        });
        [self.renderLock unlock];
    });
}


@end
