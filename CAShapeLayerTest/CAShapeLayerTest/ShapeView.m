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
        self.layer.shadowColor = [[UIColor greenColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 0.0;
        self.clipsToBounds = YES;
        
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}

-(void)didMoveToSuperview{
    
    //[CATransaction begin];
    //[CATransaction setDisableActions:YES];
    
    
    CALayer *maskedLayer = [CALayer layer];
    maskedLayer.backgroundColor = [UIColor redColor].CGColor;
    maskedLayer.position = CGPointMake(200, 200);
    maskedLayer.bounds   = CGRectMake(0, 0, 200, 200);
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.fillColor = [UIColor whiteColor].CGColor;
    mask.position = CGPointMake(100, 100);
    mask.bounds   = CGRectMake(0, 0, 200, 200);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 100);
    for (int i=0;  i<20;  i++) {
        double x = arc4random_uniform(2000) / 10.0;
        double y = arc4random_uniform(2000) / 10.0;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathCloseSubpath(path);
    
    mask.path = path;
    
    CGPathRelease(path);
    
    maskedLayer.mask = mask;
    
    CAShapeLayer *maskCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:mask]];
    maskCopy.fillColor = NULL;
    maskCopy.strokeColor = [UIColor yellowColor].CGColor;
    maskCopy.lineWidth = 1;
    maskCopy.position = maskedLayer.position;
    
    // Alternately, don't set the position and add the copy as a sublayer
    // maskedLayer.sublayers = @[maskCopy];
    
    self.layer.sublayers = @[maskedLayer,maskCopy];
    
    
    //[CATransaction commit];
    
    
    
    __block CATransform3D translate = CATransform3DMakeTranslation(100, 100, 0);
    __block CATransform3D scale = CATransform3DMakeScale(5, 2, 1);
    __block CATransform3D transform = CATransform3DConcat(translate, scale);
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:20 animations:^{
            mask.transform = transform;
        }];
    });
    
    
    /*
    CALayer *testCALayer = [CALayer new];
   // testCALayer.borderColor = [UIColor greenColor].CGColor;
    //testCALayer.borderWidth = 2;
        testCALayer.frame = self.layer.frame;
    
    //testCALayer.shadowColor = [[UIColor greenColor] CGColor];
    //testCALayer.shadowOffset = CGSizeMake(5.0, 5.0);
    //testCALayer.shadowOpacity = 1.0;
    //testCALayer.shadowRadius = 0.0;
    
    testCALayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:testCALayer];

    
    _shapeLayer = [CAShapeLayer new];
    _shapeLayer.borderColor = [UIColor blueColor].CGColor;
    _shapeLayer.lineWidth = 4;
    [self.layer addSublayer:_shapeLayer];
    
    testCALayer.mask = _shapeLayer;
    
    _shapeLayer.frame = self.layer.frame;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
        [bezierPath addLineToPoint:CGPointMake(50, 50)];
      [bezierPath addLineToPoint:CGPointMake(50, 0)];
    [bezierPath closePath];
    _shapeLayer.path = bezierPath.CGPath;
    
    __block CATransform3D translate = CATransform3DMakeTranslation(100, 100, 0);
    __block CATransform3D scale = CATransform3DMakeScale(5, 2, 1);
    __block CATransform3D transform = CATransform3DConcat(translate, scale);
    
    CAShapeLayer *testLayer =  testLayer = [CAShapeLayer new];
    testLayer.strokeColor = [UIColor greenColor].CGColor;
    testLayer.lineWidth = 4;
    [_shapeLayer addSublayer:testLayer];
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
        
        
        [UIView animateWithDuration:20 animations:^{
            _shapeLayer.transform = transform;
        }];
       
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
        [bezierPath2 moveToPoint:CGPointMake(0, 10)];
        [bezierPath2 addLineToPoint:CGPointMake(50, 60)];
        testLayer.path = bezierPath2.CGPath;
    })
    */
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    NSLog(@"layer = %@",NSStringFromCGRect(self.layer.frame));
}

@end
