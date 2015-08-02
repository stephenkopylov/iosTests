//
//  TestCollectionViewCell.m
//  CollectionViewGraphTest
//
//  Created by rovaev on 31/07/15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "TestCollectionViewCell.h"
#import "TestLayer.h"


// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation TestCollectionViewCell

{
    
    CAShapeLayer *_layer;
    
    CAShapeLayer *_layer2;
    
    dispatch_queue_t backgroundRenderQueue;
    
    //  CAShapeLayer *_layer2;
    
    CAGradientLayer *_gradient;
}

- (void)awakeFromNib
{
    
    backgroundRenderQueue = dispatch_queue_create("BackGround", DISPATCH_QUEUE_CONCURRENT);
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.drawsAsynchronously = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
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
    
    dispatch_async(backgroundRenderQueue, ^{
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        int lowerBound = -50;
        int upperBound = 50;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
        [path moveToPoint:CGPointMake(0, self.frame.size.height / 2 + rndValue)];
        
        rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height / 2 + rndValue)];
        
        UIBezierPath *fill = path.copy;
        
        [fill addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        [fill addLineToPoint:CGPointMake(0, self.frame.size.height)];
        if(!_layer){
            _layer = [CAShapeLayer new];
            _layer.lineWidth = 2;
            _layer.strokeColor = [UIColor greenColor].CGColor;
            _layer.drawsAsynchronously = YES;
            _layer.fillColor = [UIColor clearColor].CGColor;
            
            
            _layer2 = [CAShapeLayer new];
            _layer2.drawsAsynchronously = YES;
            _layer2.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
            
            _gradient = [CAGradientLayer layer];
            _gradient.drawsAsynchronously = YES;
            _gradient.frame = CGRectMake(0, 0, 3, 700);
            _gradient.startPoint = CGPointMake(0, 0);
            _gradient.endPoint = CGPointMake(0, 1);
            _gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor redColor] colorWithAlphaComponent:1] CGColor],  (id)[[[UIColor redColor] colorWithAlphaComponent:0] CGColor], nil];
            _gradient.locations = @[@(0),  @(1)];
            [_gradient setMask:_layer2];
            
            [self.layer addSublayer:_gradient];
            [self.layer addSublayer:_layer];
            
        }
        
        _layer.path = path.CGPath;
        _layer2.path = fill.CGPath;
        
    });
}




@end
