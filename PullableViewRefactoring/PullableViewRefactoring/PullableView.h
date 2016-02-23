//
//  PullableView.h
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 24/12/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, PullableViewSide) {
    PullableViewSideTop,
    PullableViewSideRight,
    PullableViewSideBottom,
    PullableViewSideLeft
};

@class PullableView;

@protocol PullableViewDelegate <NSObject>

- (void)pullableViewDidClose:(PullableView *)view;

@end

@interface PullableView : UIView

@property (nonatomic) CGFloat size;
@property (nonatomic) PullableViewSide side;
@property (nonatomic) id<PullableViewDelegate> delegate;
@property (nonatomic) UIView *innerView;
@property (nonatomic) BOOL opened;

- (instancetype)initWitSide:(PullableViewSide)side andContainerView:(UIView *)view;
- (void)open;
- (void)close;

@end
