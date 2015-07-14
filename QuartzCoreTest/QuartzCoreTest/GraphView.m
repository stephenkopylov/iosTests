//
//  GraphView.m
//  QuartzCoreTest
//
//  Created by rovaev on 14.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "GraphView.h"

#define kGraphHeight 300
#define kDefaultGraphWidth 900
#define kOffsetX 10
#define kOffsetY 10
#define kStepX 50
#define kGraphBottom 300
#define kGraphTop 0


@implementation GraphView

- (void)drawRect:(CGRect)rect
{
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0);
    
    float data[] = { 0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77, 0.99, 0.55 };
    
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);
    
    for ( int i = 1; i < sizeof(data); i++ ) {
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
     */
}


@end
