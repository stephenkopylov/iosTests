//
//  ViewController.m
//  GLKitTest
//
//  Created by Stephen Kopylov - Home on 17.09.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//


#import "ViewController.h"
#import <GLKit/GLKit.h>

@interface ViewController ()<GLKViewDelegate, GLKViewControllerDelegate>

@end

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    { { 1,  -1, 0 }, { 1, 0, 0, 1 } },
    { { 1,  1,  0 }, { 0, 1, 0, 1 } },
    { { -1, 1,  0 }, { 0, 0, 1, 1 } },
    { { -1, -1, 0 }, { 0, 0, 0, 1 } }
};

const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation ViewController {
    float _curRed;
    BOOL _increasing;
    GLKView *_glView;
    GLKViewController *_glVC;
    EAGLContext *_context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _glVC = [GLKViewController new];
    _glVC.delegate = self;
    _glVC.preferredFramesPerSecond = 60;   // 4
    [self addChildViewController:_glVC];
    [_glVC didMoveToParentViewController:self];
    
    [self.view addSubview:_glVC.view];
    
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];       // 1
    ((GLKView *)_glVC.view).context = _context;
    ((GLKView *)_glVC.view).delegate = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)render:(CADisplayLink *)dl
{
    // [glView display];
}


#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(_curRed, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}


#pragma mark - GLKViewControllerDelegate

- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    if ( _increasing ) {
        _curRed += 1.0 * controller.timeSinceLastUpdate;
    }
    else {
        _curRed -= 1.0 * controller.timeSinceLastUpdate;
    }
    
    if ( _curRed >= 1.0 ) {
        _curRed = 1.0;
        _increasing = NO;
    }
    
    if ( _curRed <= 0.0 ) {
        _curRed = 0.0;
        _increasing = YES;
    }
    
    NSLog(@"timeSinceLastUpdate: %ld", _glVC.framesPerSecond);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _glVC.paused = !_glVC.paused;
}


@end
