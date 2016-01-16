//
//  Engine.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "Engine.h"
#include <math.h>

#define DEGREES_TO_RADIANS(x)      (3.14159265358979323846 * x / 180.0)
#define RANDOM_FLOAT_BETWEEN(x, y) (((float)rand() / RAND_MAX) * (y - x) + x)

Engine::Engine()
{
}


void Engine::startDraw()
{
    glClearColor(1.0, 0.5, 0.5, 0.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, 100.0, 100.0);
}


void Engine::drawLine(Point firstPoint, Point secondPoint, float height)
{
    /*
     GLfloat line[] = {
     0,   0,   0,
     0.4, 0.3, 0
     };
     
     GLfloat colors[] = {
     1.0f, 0.0f, 0.0f, 1.0f,
     0.0f, 1.0f, 0.0f, 1.0f,
     0.0f, 0.0f, 1.0f, 1.0f
     };
     
     glShadeModel(GL_SMOOTH);
     glVertexPointer(3, GL_FLOAT, 0, line);
     glColorPointer(4, GL_FLOAT, 0, colors);
     glEnableClientState(GL_VERTEX_ARRAY);
     glEnableClientState(GL_COLOR_ARRAY);
     glClear(GL_COLOR_BUFFER_BIT);
     glDrawArrays(GL_LINES, 0, 2);
     */
    
    GLfloat vertices[720];
    
    for ( int i = 0; i < 720; i += 2 ) {
        // x value
        vertices[i]   = (cos(DEGREES_TO_RADIANS(i)) * 1);
        // y value
        vertices[i + 1] = (sin(DEGREES_TO_RADIANS(i)) * 1);
    }
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glEnableClientState(GL_VERTEX_ARRAY);
    
    glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 360);
}


void Engine::endDraw()
{
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT));
    glFlush();
}
