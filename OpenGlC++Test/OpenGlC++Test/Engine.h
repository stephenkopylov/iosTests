//
//  Engine.hpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#ifndef Engine_hpp
#define Engine_hpp

#include <stdio.h>
#include <OpenGLES/ES1/gl.h>

struct Point {
    float x, y;
    Point(float initX, int initY) {
        x = initX;
        y = initY;
    }
};


class Engine {
public:
    void startDraw();
    void drawLine(Point firstPoint, Point secondPoint, float height);
    void endDraw();
    
    Engine();
};

#endif /* Engine_hpp */
