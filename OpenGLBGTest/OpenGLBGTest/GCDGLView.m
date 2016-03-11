//
//  GCNGLView.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//
#import "GCDGLView.h"

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
    
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
//    glGenRenderbuffers(1, &_stencilbuffer);
//    glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
//    glRenderbufferStorage(GL_RENDERBUFFER, GL_STENCIL_INDEX8, GL_MAX_RENDERBUFFER_SIZE, GL_MAX_RENDERBUFFER_SIZE);
//    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    
    //    glGenRenderbuffers(1, &_depthbuffer);
    //    glBindRenderbuffer(GL_RENDERBUFFER, _depthbuffer);
    //    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_DEPTH_COMPONENT16, 1000.0, 1000.0);
    //    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthbuffer);
    
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    //    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_RGBA8_OES, 1000.0, 1000.0);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
    
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.mainLayer];
    
    
    
    dispatch_async(self.renderQueue, ^{
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        [EAGLContext setCurrentContext:self.renderContext];
        
        if ( [self.delegate respondsToSelector:@selector(setupGL:)] ) {
            [self.delegate setupGL:self];
        }
    });
    
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
    
    dispatch_async(self.renderQueue, ^{
        [self.renderLock lock];
        [EAGLContext setCurrentContext:self.renderContext];
        
        glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        
        glViewport(0, 0, frame.size.width * scale, frame.size.height * scale);
        glClearColor(.2f, 0, 0, 0.2);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

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
