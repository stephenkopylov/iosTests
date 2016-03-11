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
@property (nonatomic, strong) CAEAGLLayer *mainLayer;
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic, strong) NSLock *renderLock;
@property (nonatomic) CADisplayLink *displayLink;

@property (nonatomic) GLuint framebuffer;
@property (nonatomic) GLuint stencilbuffer;
@property (nonatomic) GLuint renderbuffer;
@property (nonatomic) GLuint depthbuffer;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
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


- (void)setup
{
    self.renderLock = [[NSLock alloc] init];
    
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.mainContext];
    
    self.mainLayer = [CAEAGLLayer new];
    self.mainLayer.frame = CGRectMake(0, 0, 100, 100);
    self.mainLayer.opaque = NO;
    self.mainLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.mainLayer];
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);

    GLint max_rb_size;
    glGetIntegerv (GL_MAX_RENDERBUFFER_SIZE, &max_rb_size);
    
    //glGenRenderbuffers(1, &_stencilbuffer);
    //glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
    //glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, max_rb_size, max_rb_size);
    
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    //glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
   // glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    
    if ( status == GL_FRAMEBUFFER_COMPLETE ) {
        NSLog(@"framebuffer complete");
        //NSLog(@"failed to make complete framebuffer object %x", status);
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
    
    if(self.displayLink){
        [self.displayLink invalidate];
    }
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    

}


- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    [EAGLContext setCurrentContext:self.mainContext];
    self.mainLayer.frame = self.layer.frame;
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.mainLayer];
}


- (void)render
{
    if ( [self.renderLock tryLock] ) {
        [self.renderLock unlock];
    }
    else {
        return;
    }
    
    
    CGRect frame =  self.layer.frame;
    CGFloat scale = [UIScreen mainScreen].scale;
    
        [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.mainLayer];
    
    dispatch_async(self.renderQueue, ^{
        [self.renderLock lock];
        [EAGLContext setCurrentContext:self.renderContext];
        
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        //glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
        //glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, frame.size.width * scale, frame.size.height * scale);
        glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
        
        glViewport(0, 0, frame.size.width * scale, frame.size.height * scale);
        glClearColor(0.f, 0.f, 0.5f, 0.3);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        if ( [self.delegate respondsToSelector:@selector(drawInRect:forView:)] ) {
            [self.delegate drawInRect:frame forView:self];
        }
        
        glFlush();
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
            [self.mainContext presentRenderbuffer:_renderbuffer];
            glFlush();
        });
        [self.renderLock unlock];
    });
}


@end
