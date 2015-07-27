//
//  testView.m
//  CAShapeLayerTest
//
//  Created by rovaev on 27/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "testView.h"

@implementation testView {
    CAShapeLayer *_shapeLayer;
    UIBezierPath *_path;
    CGFloat yScale;
    CGFloat currentYScale;
    CGAffineTransform _transform;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        yScale = 1;
        currentYScale = 1;
        _shapeLayer = [CAShapeLayer new];
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.lineWidth = 2;
        [self.layer addSublayer:_shapeLayer];
        
        _transform = CGAffineTransformMakeScale(1, 1);
        
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return self;
}


- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, 0)];
    [_path addLineToPoint:CGPointMake(500, 500)];
    
    _shapeLayer.path = _path.CGPath;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        yScale = 0.5;
    });
}


- (void)update
{
    if ( currentYScale != yScale ) {
        CGFloat diff =  fabsf(yScale - currentYScale);
        
        if ( diff > 0.1 ) {
            
            currentYScale = currentYScale + (yScale - currentYScale) / 10;
            _transform = CGAffineTransformMakeScale(1, currentYScale);
            
            [_path applyTransform:_transform];
            _shapeLayer.path = _path.CGPath;
        }
    }
}


@end
