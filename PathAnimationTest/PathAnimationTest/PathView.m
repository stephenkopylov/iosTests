//
//  PathView.m
//  PathAnimationTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "PathView.h"
#import "CShapeLayer.h"

@implementation PathView{
    UIBezierPath *_path;
    
    CShapeLayer *_layer;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        
        
    }
    return self;
}

-(void)awakeFromNib{
    [self setup];
}

-(void)setup{
    
    self.backgroundColor = [UIColor lightGrayColor];
    _path = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointMake(0, 0)];
    
    /* And end it at this point */
    for (int i = 1; i<10; i++) {
        int lowerBound = 0;
        int upperBound = 100;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        [_path addLineToPoint:CGPointMake(i*5, rndValue)];
    }
    
    _layer = [CShapeLayer new];
    _layer.strokeColor = [UIColor redColor].CGColor;
    _layer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:_layer];
    
    _layer.path = _path.CGPath;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *newPath = _path.copy;
        [newPath moveToPoint: CGPointMake(newPath.currentPoint.x + 10, 30)];
        
        //Animate path
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = 1.5f;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.repeatCount = 10;
        pathAnimation.autoreverses = YES;
        [_layer addAnimation:pathAnimation forKey:@"path"];
        
        //Animate colorFill
        CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        fillColorAnimation.duration = 1.5f;
        fillColorAnimation.fromValue = (id)[[UIColor clearColor] CGColor];
        fillColorAnimation.toValue = (id)[[UIColor yellowColor] CGColor];
        fillColorAnimation.repeatCount = 10;
        fillColorAnimation.autoreverses = YES;
        [_layer addAnimation:fillColorAnimation forKey:@"fillColor"];
        
        /*
         [_path moveToPoint: CGPointMake(_path.currentPoint.x + 10, 30)];
         [UIView animateWithDuration:0.2 animations:^{
         _layer.path = _path.CGPath;
         }];
         */
    });
}

@end
