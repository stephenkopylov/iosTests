//
//  ViewController.m
//  OpenGLBGTest
//
//  Created by Stephen Kopylov - Home on 10/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES2/glext.h>

@interface ViewController ()
@property (nonatomic, strong) CAEAGLLayer *renderLayer;
@property (nonatomic, strong) dispatch_queue_t renderQueue;
@property (nonatomic, strong) EAGLContext *renderContext;
@property (nonatomic, strong) NSLock *renderLock;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) GLuint colorRenderBuffer;
@property (nonatomic) EAGLSharegroup *sharegroup;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refresh)];
    self.displayLink.frameInterval = 60;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)refresh
{
    [self render:NO];
}


- (void)setup
{
    self.renderQueue = dispatch_queue_create("Render-Queue", DISPATCH_QUEUE_SERIAL);
    
    self.renderLock = [[NSLock alloc] init];
    
    dispatch_async(self.renderQueue, ^{
        CAEAGLLayer *layer = [[CAEAGLLayer alloc] init];
        layer.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
        layer.opaque = YES;
        layer.contentsScale = 1.0;
        layer.drawableProperties = @{
                                     kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
                                     };
        self.renderLayer = layer;
        
        _sharegroup = [EAGLSharegroup new];
        EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:_sharegroup];
        self.renderContext = context;
        [EAGLContext setCurrentContext:context];
        
        glGenRenderbuffers(1, &_colorRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
        [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
        
        GLuint framebuffer;
        glGenFramebuffers(1, &framebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                                  GL_RENDERBUFFER, _colorRenderBuffer);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            CALayer *superLayer = self.view.layer;
            [superLayer addSublayer:layer];
        });
    });
}


- (void)render:(BOOL)force
{
    if ( [self.renderLock tryLock] ) {
        [self.renderLock unlock];
    }
    else if ( !force ) {
        return;
    }
    
    __weak typeof(self) weakself = self;
    dispatch_async(self.renderQueue, ^{
        typeof(self) self = weakself;
        
        if ( self == nil ) {
            return;
        }
        
        [self.renderLock lock];
        
        [EAGLContext setCurrentContext:self.renderContext];
        glViewport(0, 0, 100.0, 100.0);
        glClearColor(10.0, 104.0 / 255.0, 55.0 / 255.0, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);
        [self.renderContext presentRenderbuffer:GL_RENDERBUFFER];
        
        [self.renderLock unlock];
    });
}


@end
