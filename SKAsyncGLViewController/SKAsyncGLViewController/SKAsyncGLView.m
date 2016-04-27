//
//  SKAsyncGLView.m
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SKAsyncGLView.h"

@interface SKAsyncGLView ()
@property (nonatomic, strong) EAGLContext *mainContext;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic) GLuint renderbuffer;
@property (nonatomic) GLuint framebuffer;
@end

@implementation SKAsyncGLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}


- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        self.renderQueue = dispatch_queue_create("Render-Queue", DISPATCH_QUEUE_SERIAL);
        ((CAEAGLLayer *)self.layer).opaque = NO;
        ((CAEAGLLayer *)self.layer).contentsScale = [UIScreen mainScreen].scale;
        
        [self createContexts];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
}


- (void)createContexts
{
    self.mainContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    dispatch_async(self.renderQueue, ^{
        self.renderContext = [[EAGLContext alloc] initWithAPI:self.mainContext.API sharegroup:self.mainContext.sharegroup];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createBuffers];
        });
    });
}


- (void)createBuffers
{
    [EAGLContext setCurrentContext:self.mainContext];
    glViewport(0, 0, 10.0, 10.0);
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        glViewport(0, 0, 10.0, 10.0);
        glGenFramebuffers(1, &_framebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderbuffer);
        
//            glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
        
        //        if ( [_delegate respondsToSelector:@selector(createBuffersForView:)] ) {
        //            [_delegate createBuffersForView:self];
        //        }
        
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}


- (void)render
{
    CGFloat width = self.frame.size.width * [UIScreen mainScreen].scale;
    CGFloat height = self.frame.size.height *  [UIScreen mainScreen].scale;
    
    [EAGLContext setCurrentContext:self.mainContext];
    [self.mainContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
    
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        
        CGRect rect = CGRectMake(0, 0, width, height);
        
        glViewport(0, 0, width, height);
        glClearColor(0.f, 0.f, 1.0f, 1.0f);
        //        if ( [_delegate respondsToSelector:@selector(drawInRect:)] ) {
        //            [_delegate drawInRect:rect];
        //        }
        
        //         if ( !self.renderable ) {
        //         return;
        //         }
        //
        glFinish();
        glFlush();
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [EAGLContext setCurrentContext:self.mainContext];
            glBindFramebuffer(GL_FRAMEBUFFER, _renderbuffer);
            glViewport(0, 0, width, height);
            
            [self.mainContext presentRenderbuffer:_renderbuffer];
            glFinish();
            glFlush();
        });
    });
}


@end
