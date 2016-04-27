//
//  ViewController.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//
#define NANOVG_GLES2_IMPLEMENTATION
#import "SampleViewController.h"
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>
#import "nanovg/nanovg.c"
#import "nanovg/nanovg.h"
#import "nanovg/nanovg_gl.h"
#import "nanovg/nanovg_gl_utils.h"

@interface SampleViewController ()<SKAsyncGLViewControllerDelegate>

@property (nonatomic) GLuint stencilbuffer;
@property (nonatomic) GLuint sampleframebuffer;
@property (nonatomic) GLuint samplestencilbuffer;
@property (nonatomic) GLuint samplerenderbuffer;

@property (nonatomic)  NVGcontext *vg;

@property (nonatomic) CGRect savedRect;

@end

@implementation SampleViewController

- (void)loadView
{
    self.delegate = self;
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


- (void)buttonTapped
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)updateBuffersSize:(CGRect)rect
{
    if ( CGRectEqualToRect(rect, _savedRect)) {
        return;
    }
    
    _savedRect = rect;
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
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
    
    [self updateBuffersSize:CGRectMake(0.0f, 0.0f, self.view.frame.size.width *[UIScreen mainScreen].scale, self.view.frame.size.height *[UIScreen mainScreen].scale)];
    
    glGenFramebuffers(1, &_sampleframebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _samplerenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _samplestencilbuffer);
    self.vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
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
    
    [self updateBuffersSize:rect];
    
    glBindRenderbuffer(GL_RENDERBUFFER, _samplestencilbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _samplerenderbuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _sampleframebuffer);
    
    glClearColor(1.f, 0.f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
    nvgBeginFrame(self.vg, roundf(self.view.frame.size.width), roundf(self.view.frame.size.height), [UIScreen mainScreen].scale);
    
    for ( int i = 0; i < 30; i++ ) {
        int randNum = rand() % (255 - 0) + 0;
        int randNum2 = rand() % (5 - 0) + 0;
        nvgStrokeColor(self.vg, nvgRGB(randNum, 0, 0));
        nvgStrokeWidth(self.vg, randNum2);
        nvgBeginPath(self.vg);
        nvgMoveTo(self.vg, 0.0, 0.0 + i * 2);
        nvgLineTo(self.vg, 100.0, 100.0 + i * 2);
        nvgStroke(self.vg);
    }
    
    nvgEndFrame(self.vg);
    
    glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, _sampleframebuffer);
    glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, self.view.framebuffer);
    glResolveMultisampleFramebufferAPPLE();
    
    const GLenum discards[]  = { GL_COLOR_ATTACHMENT0, GL_DEPTH_ATTACHMENT };
    glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE, 2, discards);
    glFlush();
}


@end
