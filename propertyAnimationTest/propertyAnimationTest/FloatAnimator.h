//
//  FloatAnimator.h
//  propertyAnimationTest
//
//  Created by rovaev on 22.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FloatAnimator;

@protocol FloatAnimatorDelegate <NSObject>

- (void)floatAnimator:(FloatAnimator *)animator didChangeValue:(float)value;

@end

@interface FloatAnimator : NSObject

@property (nonatomic) float fps;

@property (nonatomic, weak) id<FloatAnimatorDelegate> delegate;

- (instancetype)initWithFps:(float)fps;

- (void)animateFrom:(float)from andTo:(float)to withDuration:(float)duration;

@end
