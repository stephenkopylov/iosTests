//
//  FloatAnimator.m
//  propertyAnimationTest
//
//  Created by rovaev on 22.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "FloatAnimator.h"

@implementation FloatAnimator

- (instancetype)initWithFps:(float)fps
{
    self = [super init];
    
    if ( self ) {
        _fps = fps;
    }
    
    return self;
}


- (void)animateFrom:(float)from andTo:(float)to withDuration:(float)duration
{
    float timeStep = 1 / self.fps;
    
    int stepsCount = ceilf(duration / timeStep);
    
    float valueStep = (to - from) / stepsCount;
    
    __block float value = from;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for ( int i = 0; i < stepsCount; i++ ) {
            usleep(timeStep * 1000000); // sleep in microseconds
            dispatch_async(dispatch_get_main_queue(), ^{
                value += valueStep;
                
                if ( value > to ) {
                    value = to;
                }
                
                if ( [self.delegate respondsToSelector:@selector(floatAnimator:didChangeValue:)] ) {
                    [self.delegate floatAnimator:self didChangeValue:value];
                }
            });
        }
    });
}


@end
