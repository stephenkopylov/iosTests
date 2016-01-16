//
//  GraphInstance.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "GraphInstance.h"
#include <OpenGLES/ES1/gl.h>

void GraphInstance::test()
{
    glFlush();
    printf("%f\n", this->x);
    glClearColor(this->x, this->x, this->x, this->x);
}


void GraphInstance::test2()
{
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT));

}