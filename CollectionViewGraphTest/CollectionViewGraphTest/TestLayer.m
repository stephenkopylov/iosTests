//
//  TestLayer.m
//  CollectionViewGraphTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "TestLayer.h"
#import <UIKit/UIKit.h>

@implementation TestLayer
/*
-(void)drawInContext:(CGContextRef)ctx{
    
}

-(void)setPath:(CGPathRef)path{
    
    UIGraphicsBeginImageContextWithOptions([self frame].size, YES, 0.0);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    
    
    UIGraphicsEndImageContext();
    // Create an oval shape to draw.
    UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 100)];
    
    // Set the render colors.
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    //CGContextSaveGState(aRef);
    
    // Adjust the view's origin temporarily. The oval is
    // now drawn relative to the new origin point.
    CGContextTranslateCTM(aRef, 50, 50);
    
    // Adjust the drawing options as needed.
    aPath.lineWidth = 5;
    
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [aPath fill];
    [aPath stroke];
    
    // Restore the graphics state before drawing any other content.
    //CGContextRestoreGState(aRef);
}
*/

@end
