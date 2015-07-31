//
//  TestCollectionViewCell.m
//  CollectionViewGraphTest
//
//  Created by rovaev on 31/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

{
    CAShapeLayer *_layer;
    CAShapeLayer *_layer2;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    
    _layer = [CAShapeLayer new];
    
    _layer.lineWidth = 2;
    _layer.strokeColor = [UIColor greenColor].CGColor;
    _layer.drawsAsynchronously = YES;
    _layer.fillColor = [UIColor clearColor].CGColor;
    
    _layer2 = [CAShapeLayer new];
    _layer2.drawsAsynchronously = YES;
    _layer2.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    
    [self.layer addSublayer:_layer];
    [self.layer addSublayer:_layer2];
}


- (void)didMoveToSuperview
{
    [self drawPath];
}


- (void)prepareForReuse
{
    [self drawPath];
}


- (void)drawPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int lowerBound = -50;
    int upperBound = 50;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    [path moveToPoint:CGPointMake(0, self.frame.size.height / 2 + rndValue)];
    
    rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height / 2 + rndValue)];
    
    _layer.path = path.CGPath;
    
    
    UIBezierPath *fill = path.copy;
    
    [fill addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [fill addLineToPoint:CGPointMake(0, self.frame.size.height)];
    
    _layer2.path = fill.CGPath;
}


@end
