//
//  CoreGraphicsTest.m
//  CoreGraphicsTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "CoreGraphicsTest.h"

@implementation CoreGraphicsTest{
    CADisplayLink *_dLink;
    CGImageRef _bgImage;
    UIBezierPath *_path;
    dispatch_queue_t bgQueue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib{
    [self setup];
}


-(void)setup{
    bgQueue = dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT);
    _path = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointMake(0, 0)];
    
    /* And end it at this point */
    for (int i = 0; i<10000; i++) {
        int lowerBound = 0;
        int upperBound = 100;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        [_path addLineToPoint:CGPointMake(i, rndValue)];
    }
    
    _dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
    _dLink.frameInterval = 2;
    [_dLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef currentContext =UIGraphicsGetCurrentContext();
    /* Set the width for the line */
    
    CGContextDrawImage(currentContext, rect, _bgImage);
    CGImageRelease(_bgImage);
}

-(void)setShift:(CGFloat)shift{
    _shift = shift;
    
}

-(void)render{
    dispatch_async(bgQueue, ^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-_shift, 0);
        UIBezierPath *path = _path.copy;
        [path applyTransform:transform];
        UIBezierPath *fillPath = path.copy;
        
        [fillPath addLineToPoint:CGPointMake(path.currentPoint.x, self.frame.size.height)];
        [fillPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        [fillPath closePath];
        
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        CGContextRef currentContext = CGBitmapContextCreate(nil, self.frame.size.width, self.frame.size.height, 8, self.frame.size.width * (CGColorSpaceGetNumberOfComponents(space) + 1), space,kCGImageAlphaPremultipliedLast);
        CGColorSpaceRelease(space);
        
        //CGContextSetShouldAntialias(currentContext, NO);
        //CGContextSetAllowsAntialiasing(currentContext, NO);
        // CGContextSetInterpolationQuality(currentContext, kCGInterpolationNone);
        
        CGContextSetLineWidth(currentContext, 1.0);
        CGContextSetLineCap(currentContext, kCGLineCapRound);
        CGContextSetLineJoin(currentContext, kCGLineJoinRound);
        CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
        CGContextBeginPath(currentContext);
        CGContextAddPath(currentContext, path.CGPath);
        
        CGContextStrokePath(currentContext);
        
        CGFloat colors [] = {
            1.0, 1.0, 1.0, 1.0,
            1.0, 0.0, 0.0, 1.0
        };
        
        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
        CGColorSpaceRelease(baseSpace), baseSpace = NULL;
        
        CGContextBeginPath(currentContext);
        CGContextAddPath(currentContext, fillPath.CGPath);
        CGContextFillPath(currentContext);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _bgImage = CGBitmapContextCreateImage(currentContext);
            CGContextRelease(currentContext);
            [self setNeedsDisplay];
        });
    });
}

@end
