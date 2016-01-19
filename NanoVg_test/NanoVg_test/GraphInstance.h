//
//  GraphInstance.hpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#ifndef GraphInstance_hpp
#define GraphInstance_hpp

#include <stdio.h>


class GraphInstance {
public:
    float width;
    float height;
    float scale;
    void render();
    GraphInstance();
private:
};

#endif /* GraphInstance_hpp */
