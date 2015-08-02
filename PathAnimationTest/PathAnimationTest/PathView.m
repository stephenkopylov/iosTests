//
//  PathView.m
//  PathAnimationTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "PathView.h"

@implementation PathView{
    UIBezierPath *_path;
    
    CAShapeLayer *_layer;
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
        _path = [UIBezierPath bezierPath];
        
        [_path moveToPoint:CGPointMake(0, 0)];
        
        self.layer.drawsAsynchronously = YES;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        /* And end it at this point */
        for (int i = 0; i<10; i++) {
            int lowerBound = 0;
            int upperBound = 100;
            int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
            [_path addLineToPoint:CGPointMake(i*5, rndValue)];
        }
        
        _layer = [CAShapeLayer new];
        _layer
        
    }
    return self;
}


@end
