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
@property (nonatomic) ASDisplayNode *mainDisplayNode;
@property (nonatomic) ASDisplayNode *backgroundNode;
@property (nonatomic) ASDisplayNode *popupNode;

@end

@implementation BaseAsyncPopup

- (instancetype)init
{
    _mainDisplayNode = [ASDisplayNode new];
    self = [super initWithNode:_mainDisplayNode];
    
    if ( self ) {
        _backgroundNode = [ASDisplayNode new];
        _backgroundNode.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        [_mainDisplayNode addSubnode:_backgroundNode];
        
        _popupNode = [ASDisplayNode new];
        [_mainDisplayNode addSubnode:_popupNode];
        
        _mainDisplayNode.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            ASCenterLayoutSpec *centerSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:_popupNode];
            centerSpec.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                      ASRelativeDimensionMakeWithPercent(1));
            
            ASBackgroundLayoutSpec *bgLayoutSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:centerSpec background:_backgroundNode];
            
            ASStaticLayoutSpec *spec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[bgLayoutSpec]];
            return spec;
        };
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


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
        _lazyWindow = [[UIWindow alloc] init];
        _lazyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _lazyWindow.rootViewController = self;
        _lazyWindow.windowLevel = UIWindowLevelNormal;
    }
    
    return _lazyWindow;
}


@end
