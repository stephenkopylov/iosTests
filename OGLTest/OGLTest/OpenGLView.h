//
//  OpenGLView.h
//  OGLTest
//
//  Created by Stephen Kopylov - Home on 16.09.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface OpenGLView : UIView
@property (nonatomic) CAEAGLLayer *eaglLayer;
@property (nonatomic) EAGLContext *context;
@property (nonatomic) GLuint colorRenderBuffer;
@end
