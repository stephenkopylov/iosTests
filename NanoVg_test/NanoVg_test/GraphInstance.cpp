//
//  GraphInstance.cpp
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#include "GraphInstance.h"
#include "OpenGLES/ES2/glext.h"
#define NANOVG_GLES2_IMPLEMENTATION
#include "nanovg.h"
#include "nanovg_gl.h"
#include "nanovg_gl_utils.h"
#define ARC4RANDOM_MAX 0x100000000

NVGcontext *vg;

GraphInstance::GraphInstance(void)
{
    vg = nvgCreateGLES2(NVG_STENCIL_STROKES | NVG_DEBUG);
}


void GraphInstance::render()
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_CULL_FACE);
    glDisable(GL_DEPTH_TEST);
    
    nvgBeginFrame(vg, this->width, this->height, this->scale);
    
    NVGpaint bg;
    
    float samples[6];
    float sx[6], sy[6];
    float dx = this->width / 5.0f;
    int i;
    
    float yVal[100];
    
    for ( i = 0; i < sizeof(yVal) / sizeof(float); i++ ) {
        double val = ((double)arc4random() / ARC4RANDOM_MAX);
        yVal[i] = this->height * val;
    }
    
    if ( this->red ) {
        bg = nvgLinearGradient(vg, 0.0, 0.0, 0.0, this->height, nvgRGBA(255, 0, 0, 255), nvgRGBA(255, 0, 0, 64));
    }
    else {
        bg = nvgLinearGradient(vg, 0.0, 0.0, 0.0, this->height, nvgRGBA(0, 160, 192, 0), nvgRGBA(0, 160, 192, 64));
    }
    
    nvgBeginPath(vg);
    nvgMoveTo(vg, 0.0, 0.0);
    
    float pointsNumber = sizeof(yVal) / sizeof(float);
    
    for ( int i = 0; i < sizeof(yVal) / sizeof(float); i++ ) {
        nvgLineTo(vg, this->width / pointsNumber * i, yVal[i]);
    }
    
    nvgLineTo(vg, this->width, this->height);
    nvgLineTo(vg, 0.0, this->height);
    nvgFillPaint(vg, bg);
    nvgFill(vg);
    
    nvgBeginPath(vg);
    nvgMoveTo(vg, 0.0, 0.0);
    nvgLineJoin(vg, NVG_ROUND);
    
    for ( int i = 0; i < sizeof(yVal) / sizeof(float); i++ ) {
        nvgLineTo(vg, this->width / pointsNumber * i, yVal[i]);
    }
    
    nvgStrokeColor(vg, nvgRGBA(0, 160, 192, 255));
    nvgStrokeWidth(vg, 1.0f);
    nvgStroke(vg);
    
    
    nvgEndFrame(vg);
}