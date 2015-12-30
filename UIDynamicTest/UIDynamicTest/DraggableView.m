//
//  DraggableView.m
//  UIDynamicTest
//
//  Created by Stephen Kopylov - Home on 24/12/15.
//  Copyright © 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "DraggableView.h"

@interface DraggableView ()
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *snap;
@property (nonatomic) UIDynamicItemBehavior *resistance;
@end

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension)
{
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}


@implementation DraggableView

- (void)awakeFromNib
{
    [self setup];
}


- (void)setup
{
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
    _snap = [[UIAttachmentBehavior alloc] initWithItem:self offsetFromCenter:UIOffsetMake(0, 0) attachedToAnchor:self.center];
    _snap.damping = 1.0;
    
    _resistance = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    _resistance.resistance = 50.0;
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.superview];
    
    if ( recognizer.state == UIGestureRecognizerStateBegan ) {
        [self.animator removeAllBehaviors];
        _originalPosition = self.center;
    }
    else if ( recognizer.state == UIGestureRecognizerStateChanged ) {
        CGPoint newPosition = CGPointZero;
        CGPoint translation = [recognizer translationInView:self];
        
        CGFloat newBoundsOriginX = _originalPosition.x - translation.x;
        //CGFloat minBoundsOriginX = 0.0;
        //CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
        //CGFloat constrainedBoundsOriginX = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
        CGFloat rubberBandedX = rubberBandDistance(newBoundsOriginX - _originalPosition.x, CGRectGetWidth(self.bounds));
        newPosition.x = _originalPosition.x + rubberBandedX;
        
        /*
         CGFloat newBoundsOriginY = bounds.origin.y - translation.y;
         CGFloat minBoundsOriginY = 0.0;
         CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
         CGFloat constrainedBoundsOriginY = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
         CGFloat rubberBandedY = rubberBandDistance(newBoundsOriginY - constrainedBoundsOriginY, CGRectGetHeight(self.bounds));
         bounds.origin.y = constrainedBoundsOriginY + rubberBandedY;
         */
        
        CGFloat newBoundsOriginY = _originalPosition.y - translation.y;
        //CGFloat minBoundsOriginX = 0.0;
        //CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
        //CGFloat constrainedBoundsOriginX = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));
        CGFloat rubberBandedY = rubberBandDistance(newBoundsOriginY - _originalPosition.y, CGRectGetWidth(self.bounds));
        newPosition.y = _originalPosition.y + rubberBandedY;
        
        self.center = newPosition;
    }
    else if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        [self.animator removeAllBehaviors];
        [self.animator addBehavior:_resistance];
        [self.animator addBehavior:_snap];
    }
}


@end
