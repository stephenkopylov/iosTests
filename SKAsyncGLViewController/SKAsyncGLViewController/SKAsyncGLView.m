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
    glGenRenderbuffers(1, &_renderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    dispatch_async(self.renderQueue, ^{
        [EAGLContext setCurrentContext:self.renderContext];
        
        glGenFramebuffers(1, &_framebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        
        if ( [_delegate respondsToSelector:@selector(createBuffers:)] ) {
            [_delegate createBuffers:self];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}


@end
