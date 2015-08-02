//
//  TestView.m
//  CALayerAsyncDrawTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [self drawSkyInRect:rect inContext:context withColorSpace:colorSpace];
    CGColorSpaceRelease(colorSpace);
}


-(void) drawSkyInRect: (CGRect) rect inContext: (CGContextRef) context withColorSpace: (CGColorSpaceRef) colorSpace
{
    
    
    CGContextRef ctx = CGContextRetain(context);
    
    UIColor * baseColor = [UIColor colorWithRed:148.0/255.0 green:158.0/255.0 blue:183.0/255.0 alpha:1.0];
    UIColor * middleStop = [UIColor colorWithRed:127.0/255.0 green:138.0/255.0 blue:166.0/255.0 alpha:1.0];
    UIColor * farStop = [UIColor colorWithRed:255.0/255.0 green:13.0/255.0 blue:144.0/255.0 alpha:1.0];
    
    CGContextSaveGState(context);
    NSArray * gradientColors = @[(__bridge id)baseColor.CGColor, (__bridge id)middleStop.CGColor, (__bridge id)farStop.CGColor];
    CGFloat locations[] = { 0.0, 0.5, 1 };
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, locations);
    
    CGPoint startPoint = CGPointMake(rect.size.height / 2, 0);
    CGPoint endPoint = CGPointMake(rect.size.height / 2, rect.size.width);
    
    
    
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
    
    
}


@end
