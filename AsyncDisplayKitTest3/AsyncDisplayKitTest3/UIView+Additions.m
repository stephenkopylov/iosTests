//
//  UIView+Additions.m
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 03/11/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "UIView+Additions.h"
#import "UIView+Shake.h"

@implementation UIView (Additions)

- (void)invalidShake
{
    [self shake:4 withDelta:10 speed:0.06];
}


- (void)attentionShake
{
    [self shake:3 withDelta:3.0 speed:0.1 shakeDirection:ShakeDirectionVertical];
}


- (UIViewController *)firstAvailableUIViewController
{
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}


- (id)traverseResponderChainForUIViewController
{
    id nextResponder = [self nextResponder];
    
    if ( [nextResponder isKindOfClass:[UIViewController class]] ) {
        return nextResponder;
    }
    else if ( [nextResponder isKindOfClass:[UIView class]] ) {
        return [nextResponder traverseResponderChainForUIViewController];
    }
    else {
        return nil;
    }
}


- (void)runBlockOnAllSubviews:(SubviewBlock)block
{
    block(self);
    
    for ( UIView *view in [self subviews] ) {
        [view runBlockOnAllSubviews:block];
    }
}


- (void)runBlockOnAllSuperviews:(SuperviewBlock)block
{
    block(self);
    
    if ( self.superview ) {
        [self.superview runBlockOnAllSuperviews:block];
    }
}


- (UIView *)rootView
{
    UIView *view = self;
    
    while ( view.superview != nil )
        view = view.superview;
    return view;
}


- (UIView *)getViewWithAccebityIdentifier:(NSString *)accebityIdentifier
{
    __block UIView *findedView;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    [windows enumerateObjectsUsingBlock:^(UIWindow *window, NSUInteger idx, BOOL *_Nonnull stop) {
        UIView *rView = [window.rootViewController.view rootView];
        
        [rView runBlockOnAllSubviews:^(UIView *view) {
            if ( [view.accessibilityIdentifier isEqualToString:accebityIdentifier] ) {
                findedView = view;
            }
        }];
        
        rView = [window.rootViewController.presentedViewController.view rootView];
        
        [rView runBlockOnAllSubviews:^(UIView *view) {
            if ( [view.accessibilityIdentifier isEqualToString:accebityIdentifier] ) {
                findedView = view;
            }
        }];
    }];
    
    return findedView;
}


- (void)animateDown
{
    [UIView animateWithDuration:0.03f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.95, 0.95);
        self.layer.opacity = 0.6f;
    } completion:nil];
}


- (void)animateUp
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.opacity = 1.0f;
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}


@end
