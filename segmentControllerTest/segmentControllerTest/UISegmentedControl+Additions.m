//
//  UISegmentedControl+Fade.m
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 13/01/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UISegmentedControl+Additions.h"

@implementation UISegmentedControl (Additions)

- (void)setFadeEnabled:(BOOL)fadeEnabled
{
    [UIView animateWithDuration:0.2 animations:^{
        self.enabled = fadeEnabled;
    }];
}


- (BOOL)fadeEnabled
{
    return self.enabled;
}


- (void)removeBorders
{
    [self setBackgroundImage:[self imageWithColor:self.backgroundColor] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self imageWithColor:self.tintColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self imageWithColor:self.tintColor] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self imageWithColor:self.tintColor] forState:UIControlStateApplication barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:[self imageWithColor:self.tintColor] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[self imageWithColor:self.tintColor] forLeftSegmentState:UIControlStateDisabled rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[self imageWithColor:self.tintColor] forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
