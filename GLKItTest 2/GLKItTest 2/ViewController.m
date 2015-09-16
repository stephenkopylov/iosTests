//
//  ViewController.m
//  GLKItTest 2
//
//  Created by Stephen Kopylov - Home on 17.09.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<GLKViewDelegate, GLKViewControllerDelegate>

@end

@implementation ViewController {
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    EAGLContext *_context;
    GLKBaseEffect *_effect;
    float _rotation;
}

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    { { 1,  -1,  0 }, { 1, 0, 0, 1 } },
    { { 1,  1,   0 }, { 0, 1, 0, 1 } },
    { { -1, 1,   0 }, { 0, 0, 1, 1 } },
    { { -1, -1,  0 }, { 0, 0, 0, 1 } }
};

const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0
};

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [self setupGL];
    self.delegate = self;
    self.preferredFramesPerSecond = 60;
    ((GLKView *)self.view).context = _context;
    ((GLKView *)self.view).delegate = self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self setupGL];
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:_context];
    
    _effect = [[GLKBaseEffect alloc] init];
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
}


- (void)tearDownGL
{
    [EAGLContext setCurrentContext:_context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    _effect = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [_effect prepareToDraw];
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Color));
    
    glDrawElements(GL_TRIANGLES, sizeof(Indices) / sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
}


#pragma mark - GLKViewControllerDelegate
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f);
    
    _effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    _rotation += 90 * self.timeSinceLastUpdate;
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotation), 0, 0, 1);
    _effect.transform.modelviewMatrix = modelViewMatrix;
    
    NSLog(@"timeSinceLastUpdate: %ld", self.framesPerSecond);
}


@end
