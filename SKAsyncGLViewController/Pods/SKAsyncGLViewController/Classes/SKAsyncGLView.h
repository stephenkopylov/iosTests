//
//  SKAsyncGLView.h
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class SKAsyncGLView;

@protocol SKAsyncGLViewDelegate <NSObject>

- (void)createBuffersForView:(SKAsyncGLView *)asyncView;

- (void)drawInRect:(CGRect)rect;

- (void)removeBuffersForView:(SKAsyncGLView *)asyncView;

@end

@interface SKAsyncGLView : UIView

@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, weak) id<SKAsyncGLViewDelegate> delegate;
@property (nonatomic) GLuint renderbuffer;
@property (nonatomic) GLuint framebuffer;

- (void)render;

@end
