//
//  ShapeView.m
//  CAShapeLayerTest
//
//  Created by rovaev on 27/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView{
    CAShapeLayer *_shapeLayer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
 
    }
    return self;
}

-(void)didMoveToSuperview{
    _shapeLayer = [CAShapeLayer new];
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.lineWidth = 4;
    [self.layer addSublayer:_shapeLayer];
    
    _shapeLayer.frame = self.layer.frame;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
        [bezierPath addLineToPoint:CGPointMake(50, 50)];
    _shapeLayer.path = bezierPath.CGPath;
    
    __block CATransform3D translate = CATransform3DMakeTranslation(100, 100, 0);
    __block CATransform3D scale = CATransform3DMakeScale(5, 5, 1);
    __block CATransform3D transform = CATransform3DConcat(translate, scale);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
        
        
        [UIView animateWithDuration:20 animations:^{
            _shapeLayer.transform = transform;
        }];
       
    });
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(11 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       translate = CATransform3DMakeTranslation(0, 0, 0);
        scale = CATransform3DMakeScale(1, 1, 1);
       transform = CATransform3DConcat(translate, scale);
        
        [UIView animateWithDuration:5 animations:^{
            _shapeLayer.transform = transform;
        }];
    });
     */
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    NSLog(@"layer = %@",NSStringFromCGRect(self.layer.frame));
}

@end
