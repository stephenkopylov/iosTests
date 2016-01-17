//
//  Engine.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "Engine.h"
#include <math.h>

Engine::Engine()
{
}


void Engine::startDraw()
{
    glClearColor(1.0, 0.5, 0.5, 1.0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //Берем высоту вьюпорта
    GLint m_viewport[4];
    glGetIntegerv(GL_VIEWPORT, m_viewport);
    
    //Настраиваем проекцию
    glOrthof(0, m_viewport[2], m_viewport[3], 0, -1, 1);
    
    glEnable(GL_LINE_SMOOTH);
    glHint( GL_LINE_SMOOTH_HINT, GL_NICEST );
}


void Engine::drawLine(Point firstPoint, Point secondPoint, float height)
{
    GLfloat line[] = {
        firstPoint.x,  firstPoint.y,
        secondPoint.x, secondPoint.y,
    };
    
    GLubyte colors[] = {
        20,  200,  0,    255,
        255, 0,    0,    250,
    };
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    
    glVertexPointer(2, GL_FLOAT, 0, line);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);
    glLineWidth(height);
    
    glDrawArrays(GL_LINES, 0, 3);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
    glLineWidth(1.0);
}


void Engine::endDraw()
{
    glFlush();
}
