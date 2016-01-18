//
//  GraphInstance.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "GraphInstance.h"
#include "OpenGLES/ES2/glext.h"

//#include "Engine.h"

//Engine engine;

float xxx;

GraphInstance::GraphInstance()
{
    // engine = Engine();
}


void GraphInstance::test()
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_CULL_FACE);
    glDisable(GL_DEPTH_TEST);
}


void GraphInstance::test2()
{
}