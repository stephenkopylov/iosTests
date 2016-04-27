//
//  ViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>

@interface ViewController ()<SKAsyncGLViewControllerDelegate>

@property (nonatomic) GLuint stencilbuffer;

@property (nonatomic) GLuint sampleframebuffer;
@property (nonatomic) GLuint samplestencilbuffer;
@property (nonatomic) GLuint samplerenderbuffer;

@end

@implementation ViewController

- (void)loadView
{
    self.delegate = self;
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


- (void)updateBuffersSize
{
    CGFloat width = self.view.frame.size.width * [UIScreen mainScreen].scale;
    CGFloat height = self.view.frame.size.height * [UIScreen mainScreen].scale;
    
    glBindRenderbuffer(GL_RENDERBUFFER, _stencilbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, width, height);
    
    GLint samples;
    glGetIntegerv(GL_MAX_SAMPLES_APPLE, &samples);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_RGBA8_OES, width, height);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, samples, GL_DEPTH24_STENCIL8_OES, width, height);
}


#pragma mark - SKAsyncGLViewControllerDelegate

- (void)createBuffers:(SKAsyncGLViewController *)viewController
{
    NSLog(@"create buffers");
    
    glGenRenderbuffers(1, &_stencilbuffer);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _stencilbuffer);
    
    glGenRenderbuffers(1, &_samplerenderbuffer);
    glGenRenderbuffers(1, &_samplestencilbuffer);
    
    [self updateBuffersSize];
    
    glGenFramebuffers(1, &_sampleframebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _samplerenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
    
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
}


- (void)removeBuffers:(SKAsyncGLViewController *)viewController
{
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
}


#pragma mark - SKAsyncGLViewDelegate

- (void)drawInRect:(CGRect)rect
{
    glViewport(0, 0, rect.size.width, rect.size.height);
    
    [self updateBuffersSize];
    
    glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
    
    glClearColor(1.f, 0.f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
    glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, _sampleframebuffer);
    glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, self.view.framebuffer);
    glResolveMultisampleFramebufferAPPLE();
    
    const GLenum discards[]  = { GL_COLOR_ATTACHMENT0, GL_DEPTH_ATTACHMENT };
    glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE, 2, discards);
    glFlush();
}


@end
