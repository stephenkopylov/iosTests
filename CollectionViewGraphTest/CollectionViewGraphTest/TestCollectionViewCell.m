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
    CALayer *_testLayer;
    
    CAShapeLayer *_layer;
  //  CAShapeLayer *_layer2;
    
    //UIImageView *_imageView;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
 /*
    _imageView = [UIImageView new];
    _imageView.frame = CGRectMake(0, 0, 3, 700);
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [_imageView setImage:[UIImage imageNamed:@"test"]];
    
    [self addSubview:_imageView];
    */
    
    _layer = [CAShapeLayer new];
    
    _layer.lineWidth = 2;
    _layer.strokeColor = [UIColor greenColor].CGColor;
    _layer.drawsAsynchronously = YES;
    _layer.fillColor = [UIColor clearColor].CGColor;
    
    /*
    _layer2 = [CAShapeLayer new];
    _layer2.drawsAsynchronously = YES;
    _layer2.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    */
     
    _testLayer = [CALayer new];
   // _testLayer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    /*
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.shouldRasterize = YES;
    gradient.frame = CGRectMake(0, 0, 3, 700);
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor redColor] colorWithAlphaComponent:1] CGColor],  (id)[[[UIColor redColor] colorWithAlphaComponent:0] CGColor], nil];
    gradient.locations = @[@(0),  @(1)];
    [self.layer addSublayer:gradient];
    
    */
    
    _testLayer.contents = (id) [UIImage imageNamed:@"test"].CGImage;
    _testLayer.delegate = self;
    [self.layer addSublayer:_layer];
    [self.layer addSublayer:_testLayer];
    
    //[_imageView.layer setMask:_layer2];
    
    self.layer.drawsAsynchronously = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
       // [_testLayer setNeedsDisplay];
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
    

    
    //_testLayer.path = fill.CGPath;
}


void MyDrawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, DEGREES_TO_RADIANS(360), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, DEGREES_TO_RADIANS(360), 0);
    CGContextFillPath(context);
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           layer.bounds,
                                           CGAffineTransformIdentity,
                                           24,
                                           24,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
}

@end
