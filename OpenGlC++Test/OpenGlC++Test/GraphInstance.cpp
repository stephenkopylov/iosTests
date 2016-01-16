//
//  GraphInstance.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "GraphInstance.h"
#include "Engine.h"

Engine engine;

GraphInstance::GraphInstance()
{
    engine = Engine();
}


void GraphInstance::test()
{
    printf("%f\n", this->x);
    
    Point firstPoint = Point(0.0, 0.0);
    Point secondPoint = Point(100.0, 100.0);
    
    engine.startDraw();
    engine.drawLine(firstPoint, secondPoint, 2.0);
    engine.startDraw();
}


void GraphInstance::test2()
{
}