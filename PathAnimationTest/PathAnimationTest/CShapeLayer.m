//
//  CShapeLayer.m
//  PathAnimationTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "CShapeLayer.h"

@implementation CShapeLayer

- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"path"]) {
        CABasicAnimation *animation = [CABasicAnimation
                                       animationWithKeyPath:event];
        animation.duration = [CATransaction animationDuration];
        animation.timingFunction = [CATransaction
                                    animationTimingFunction];
        return animation;
    }
    return [super actionForKey:event];
}

@end
