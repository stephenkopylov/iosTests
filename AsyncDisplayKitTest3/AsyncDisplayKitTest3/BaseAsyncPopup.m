//
//  BaseAsyncPopup.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 01/06/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "BaseAsyncPopup.h"

@interface BaseAsyncPopup ()

@property (nonatomic) UIWindow *lazyWindow;
@property (nonatomic) ASDisplayNode *backgroundNode;
@property (nonatomic) ASDisplayNode *containerNode;
@property (nonatomic) ASDisplayNode *popupNode;

@end

@implementation BaseAsyncPopup

- (instancetype)init
{
    self = [super initWithNode:[ASDisplayNode new]];
    
    if ( self ) {
        _backgroundNode = [ASDisplayNode new];
        _backgroundNode.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self.node addSubnode:_backgroundNode];
        
        _containerNode = [ASDisplayNode new];
        _containerNode.layer.cornerRadius = 5.f;
        _containerNode.flexGrow = YES;
        _containerNode.flexShrink = YES;
        _containerNode.backgroundColor = [UIColor blueColor];
        [self.node addSubnode:_containerNode];
        
        _popupNode = [ASDisplayNode new];
        _popupNode.flexGrow = YES;
        _popupNode.flexShrink = YES;
        _popupNode.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                  ASRelativeDimensionMakeWithPercent(1));
        [self fillNode:_popupNode];
        [_containerNode addSubnode:_popupNode];
        
        _popupNode.layoutSpecBlock =  ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            return [self specForNode];
        };
        
        _containerNode.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:_popupNode];
            return insetSpec;
        };
        
        self.node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            ASCenterLayoutSpec *centerSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:_containerNode];
            ASStaticLayoutSpec *spec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[centerSpec]];
            
            ASBackgroundLayoutSpec *bgLayoutSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:spec background:_backgroundNode];
            bgLayoutSpec.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                        ASRelativeDimensionMakeWithPercent(1));
            
            return bgLayoutSpec;
        };
    }
    
    return self;
}


- (void)fillNode:(ASDisplayNode *)node
{
}


- (ASLayoutSpec *)specForNode
{
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.alpha = 0.0f;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f animations:^{
            self.view.alpha = 1.0f;
        }];
    });
}


//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"size = %@", NSStringFromCGSize(self.lazyWindow.frame.size));
//        [_mainDisplayNode measure:self.lazyWindow.frame.size];
//    });
//}


- (void)show
{
    [self.lazyWindow makeKeyAndVisible];
}


- (void)hide
{
    [self.lazyWindow resignKeyWindow];
    self.lazyWindow = nil;
}


- (UIWindow *)lazyWindow
{
    if ( _lazyWindow == nil ) {
        _lazyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _lazyWindow.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];
        _lazyWindow.rootViewController = self;
        _lazyWindow.windowLevel = UIWindowLevelNormal;
    }
    
    return _lazyWindow;
}


@end
