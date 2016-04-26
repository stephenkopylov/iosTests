//
//  GCNGLView.h
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@class GCDGLView;

@protocol GCDGLViewDelegate <NSObject>

- (void)setupGL:(GCDGLView *)view;

- (void)drawInRect:(CGRect)rect forView:(GCDGLView *)view;

@end

@interface GCDGLView : UIView

- (instancetype)initWithRenderQueue:(dispatch_queue_t)renderQueue;

- (void)render;

@property (nonatomic, weak) id<GCDGLViewDelegate> delegate;

@property (nonatomic) BOOL debug;

@end