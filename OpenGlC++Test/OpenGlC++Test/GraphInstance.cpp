//
//  GraphInstance.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "GraphInstance.h"
#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/gl.h>
void GraphInstance::test()
{
    glClearColor(1.0, 0.0, 0.0, 1.0);
}


void GraphInstance::test2()
{
    GLfloat rect[] = {
        0,   100,
        100, 100,
        100, 100,
        100, 100
    };
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glColor4f(20.0f, 20.0f, 20.0f, 244.0f);
    glVertexPointer(2, GL_FLOAT, 0, rect);
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}