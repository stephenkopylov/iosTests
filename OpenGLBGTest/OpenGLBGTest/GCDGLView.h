//
//  GCNGLView.h
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 11/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import <GLKit/GLKit.h>

@class GCDGLView;

@protocol GCDGLViewDelegate <NSObject>

- (void)setupGL:(GCDGLView *)view;

- (void)drawInRect:(CGRect)rect forView:(GCDGLView *)view;

@end

@interface GCDGLView : UIView

@property (nonatomic, weak) id<GCDGLViewDelegate> delegate;

@end
