//
//  PlotView.m
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "PlotView.h"
#include "GraphInstance.h"
#include <OpenGLES/ES1/gl.h>

@interface PlotView ()
@property (assign, nonatomic) GLuint        defaultFramebuffer;
@property (assign, nonatomic) GLuint        colorRenderbuffer;
@end

@implementation PlotView {
    GraphInstance test;
    EAGLContext *_context;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        test = GraphInstance();
        
        srand48(arc4random());
        
        double x = drand48();
        test.x =  x;
        
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        GLKView *view = [[GLKView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.context = _context;
        view.backgroundColor = [UIColor redColor];
        view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        view.delegate = self;
        view.enableSetNeedsDisplay = YES;
        [self addSubview:view];
        
        
        glGenFramebuffers(1, &_defaultFramebuffer);
        glBindBuffer(GL_FRAMEBUFFER, self.defaultFramebuffer);
        glGenRenderbuffers(1, &_colorRenderbuffer);
        glBindBuffer(GL_RENDERBUFFER, self.colorRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER,
                                 GL_RGBA4,
                                 view.bounds.size.width,
                                 view.bounds.size.height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                                     GL_COLOR_ATTACHMENT0,
                                     GL_RENDERBUFFER,
                                     self.colorRenderbuffer);
    }
    
    return self;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
        [EAGLContext setCurrentContext:_context];
    glClear(GL_COLOR_BUFFER_BIT);
    /* 頂点の定義 */
    GLfloat vertices[] = {
        -0.5f, -0.5f,
        0.5f, -0.5f,
        0.0f, 0.5f,
    };
    /* カラー（RGBA）の定義 */
    GLubyte colors[] = {
        255, 0, 0, 255,
        255, 0, 0, 255,
        255, 0, 0, 255,
    };
    /* 頂点配列とカラー配列を有効 */
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    /* 頂点配列とカラー配列を設定 */
    glVertexPointer(2 , GL_FLOAT , 0 , vertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    /* 描画 */
    glDrawArrays(GL_TRIANGLES, 0, 3);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
    /*
    [EAGLContext setCurrentContext:_context];
    test.test();
    test.test2();
     */
}


@end
