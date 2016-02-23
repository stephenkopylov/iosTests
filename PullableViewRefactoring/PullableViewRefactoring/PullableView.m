//
//  PullableView.m
//  ExpertOption
//
//  Created by Stephen Kopylov - Home on 24/12/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "PullableView.h"

@interface PullableView ()
@property (nonatomic) NSLayoutConstraint *sizeConstraint;
@property (nonatomic) NSLayoutConstraint *positionConstraint;
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic) UIDynamicAnimator *lazyAnimator;
@property (nonatomic) DynamicHub *lazyDynamicHub;

@property (nonatomic) UISnapBehavior *minSnap;
@property (nonatomic) UISnapBehavior *maxSnap;
@property (nonatomic) UISnapBehavior *openedSnap;
@property (nonatomic) UISnapBehavior *closedSnap;

@property (nonatomic) CGFloat originalPosition;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat openedValue;
@property (nonatomic) CGFloat closedValue;

@property (nonatomic) CGFloat margin;
@end

@implementation PullableView

#pragma mark - livecycle

- (void)removeFromSuperview
{
    [super removeFromSuperview];
}


#pragma mark - public methods

- (instancetype)initWitSide:(PullableViewSide)side andContainerView:(UIView *)view
{
    self = [self init];
    
    if ( self ) {
        _side = side;
        _containerView = view;
        [_containerView addSubview:self];
        [self setup];
    }
    
    return self;
}


- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _side = PullableViewSideTop;
    }
    
    return self;
}


- (void)didMoveToSuperview
{
    if ( !_containerView ) {
        _containerView = self.superview;
        [self setup];
    }
}


- (void)setup
{
    self.opened = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *vfl;
    
    NSDictionary *views = @{
                            @"container": _containerView,
                            @"view": self,
                            };
    
    
    NSLayoutAttribute sizeAttribute;
    
    if ( _side == PullableViewSideTop || _side == PullableViewSideBottom ) {
        vfl = @"|[view]|";
        sizeAttribute = NSLayoutAttributeHeight;
    }
    else {
        vfl = @"V:|[view]|";
        sizeAttribute = NSLayoutAttributeWidth;
    }
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:nil views:views]];
    
    NSLayoutAttribute positionAttribute;
    NSLayoutAttribute blurAttribute;
    
    switch ( _side )
    {
        case PullableViewSideTop: {
            positionAttribute = NSLayoutAttributeTop;
            blurAttribute = NSLayoutAttributeBottom;
            break;
        }
            
        case PullableViewSideRight: {
            positionAttribute = NSLayoutAttributeRight;
            blurAttribute = NSLayoutAttributeLeft;
            break;
        }
            
        case PullableViewSideBottom: {
            positionAttribute = NSLayoutAttributeBottom;
            blurAttribute = NSLayoutAttributeTop;
            break;
        }
            
        case PullableViewSideLeft: {
            positionAttribute = NSLayoutAttributeLeft;
            blurAttribute = NSLayoutAttributeRight;
            break;
        }
    }
    
    _sizeConstraint = [NSLayoutConstraint constraintWithItem:self attribute:sizeAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:0.0f];
    _positionConstraint = [NSLayoutConstraint constraintWithItem:self attribute:positionAttribute relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:positionAttribute multiplier:1.0 constant:0.0f];
    
    [_containerView addConstraint:_sizeConstraint];
    [_containerView addConstraint:_positionConstraint];
    
    [self calculateMinMax];
}


- (void)open
{
    [self calculateMinMax];
    
    [self snapTo:_openedSnap];
}


- (void)close
{
    [self calculateMinMax];
    
    [self snapTo:_closedSnap];
}


#pragma mark - pan gesture handling

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:_containerView];
    
    [self calculateMinMax];
    
    if ( recognizer.state == UIGestureRecognizerStateBegan ) {
        [self.lazyAnimator removeAllBehaviors];
        _originalPosition = _positionConstraint.constant;
    }
    else if ( recognizer.state == UIGestureRecognizerStateChanged ) {
        CGFloat newPosition;
        
        if ( _side == PullableViewSideTop || _side == PullableViewSideBottom ) {
            newPosition = _originalPosition + translation.y;
        }
        else {
            newPosition = _originalPosition + translation.x;
        }
        
        if ( newPosition > self.maxValue ) {
            CGFloat distance = self.maxValue - newPosition;
            newPosition = self.maxValue - distance / 5;
        }
        else if ( newPosition < self.minValue ) {
            CGFloat distance = self.minValue - newPosition;
            newPosition = self.minValue - distance / 5;
        }
        
        self.margin = newPosition;
    }
    else if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        CGPoint velocity = [recognizer velocityInView:self];
        
        if ( fabs(velocity.y) > 1 ) {
            UIDynamicItemBehavior *decelerationBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.lazyDynamicHub]];
            [decelerationBehavior addLinearVelocity:velocity forItem:self.lazyDynamicHub];
            decelerationBehavior.resistance = 2.0;
            
            
            [decelerationBehavior setAction:^{
                CGFloat newPosition = self.lazyDynamicHub.center.y;
                
                CGFloat diff = fabs(self.lazyDynamicHub.center.y - self.positionConstraint.constant);
                
                if ( diff > 10 ) {
                    self.margin = newPosition;
                    
                    if ( newPosition > self.maxValue ) {
                        [self snapToClosest];
                    }
                    else if ( newPosition < self.minValue ) {
                        [self snapToClosest];
                    }
                }
                else {
                    [self snapToClosest];
                }
            }];
            
            [self.lazyAnimator addBehavior:decelerationBehavior];
        }
        else {
            [self snapToClosest];
        }
    }
}


#pragma mark - private methods

- (void)calculateMinMax
{
    if ( _side == PullableViewSideTop || _side == PullableViewSideLeft ) {
        self.minValue = -_size;
        self.maxValue = 0;
        self.openedValue = _maxValue;
        self.closedValue = _minValue;
    }
    else {
        self.minValue = 0;
        self.maxValue = _size;
        self.openedValue = _minValue;
        self.closedValue = _maxValue;
    }
    
    _minSnap = [[UISnapBehavior alloc] initWithItem:self.lazyDynamicHub snapToPoint:CGPointMake(0, self.minValue)];
    _minSnap.damping = 0.99;
    
    [_minSnap setAction:^{
        CGFloat newPosition = self.lazyDynamicHub.center.y;
        self.margin = newPosition;
    }];
    
    _maxSnap = [[UISnapBehavior alloc] initWithItem:self.lazyDynamicHub snapToPoint:CGPointMake(0, self.maxValue)];
    _minSnap.damping = 0.99;
    [_maxSnap setAction:^{
        CGFloat newPosition = self.lazyDynamicHub.center.y;
        self.margin = newPosition;
    }];
    
    if ( _side == PullableViewSideTop || _side == PullableViewSideLeft ) {
        _openedSnap = _maxSnap;
        _closedSnap = _minSnap;
    }
    else {
        _openedSnap = _minSnap;
        _closedSnap = _maxSnap;
    }
}


- (void)snapToClosest
{
    CGFloat test = (self.maxValue - self.minValue) / 2 - (_positionConstraint.constant - self.minValue);
    
    self.lazyDynamicHub.center = CGPointMake(0, _positionConstraint.constant);
    
    UISnapBehavior *snapTo;
    
    if ( test < 0 ) {
        snapTo = _maxSnap;
    }
    else {
        snapTo = _minSnap;
    }
    
    [self snapTo:snapTo];
}


- (void)snapTo:(UISnapBehavior *)snapBehavior
{
    [self.lazyAnimator removeAllBehaviors];
    [self.lazyAnimator addBehavior:snapBehavior];
    
    if ( snapBehavior == _openedSnap ) {
        self.opened = YES;
    }
    else {
        self.opened = NO;
    }
}


#pragma mark - getters/setters

- (void)setMargin:(CGFloat)margin
{
    _margin = margin;
    _positionConstraint.constant = margin;
    self.lazyDynamicHub.center = CGPointMake(0, _margin);
}


- (void)setSize:(CGFloat)size
{
    _size = size;
    _sizeConstraint.constant = _size;
    
    [self calculateMinMax];
    
    if ( !_opened ) {
        self.margin = _closedValue;
        [self.containerView layoutIfNeeded];
    }
}


- (void)setInnerView:(UIView *)innerView
{
    if ( _innerView ) {
        [_innerView removeFromSuperview];
        _innerView = nil;
    }
    
    _innerView = innerView;
    _innerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_innerView];
    
    [_innerView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_innerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_innerView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_innerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSDictionary *views = @{
                            @"innerView": innerView,
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[innerView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[innerView]|" options:0 metrics:nil views:views]];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_innerView addGestureRecognizer:_panGestureRecognizer];
}


- (void)setBlurred:(BOOL)blurred
{
}


- (UIDynamicAnimator *)lazyAnimator
{
    if ( _lazyAnimator == nil ) {
        _lazyAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    
    return _lazyAnimator;
}


- (DynamicHub *)lazyDynamicHub
{
    if ( _lazyDynamicHub == nil ) {
        _lazyDynamicHub = [DynamicHub new];
    }
    
    return _lazyDynamicHub;
}


@end


@implementation DynamicHub

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _bounds = CGRectMake(0, 0, 100, 100);
    }
    
    return self;
}


@end
