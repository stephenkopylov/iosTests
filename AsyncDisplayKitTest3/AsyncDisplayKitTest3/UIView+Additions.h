//
//  UIView+Additions.h
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 03/11/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SubviewBlock) (UIView *view);
typedef void (^SuperviewBlock) (UIView *superview);

@interface UIView (Additions)

- (void)invalidShake;
- (void)attentionShake;
- (UIViewController *)firstAvailableUIViewController;
- (id)traverseResponderChainForUIViewController;
- (void)runBlockOnAllSubviews:(SubviewBlock)block;
- (void)runBlockOnAllSuperviews:(SuperviewBlock)block;
- (UIView *)rootView;
- (UIView *)getViewWithAccebityIdentifier:(NSString *)accebityIdentifier;
- (void)animateDown;
- (void)animateUp;
@end
