//
//  AssetsBlockNode.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 28/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "AssetsBlockNode.h"
#import "BaseButtonNode.h"

@interface AssetsBlockNode ()
@property (nonatomic) BaseButtonNode *button1;
@property (nonatomic) BaseButtonNode *button2;
@property (nonatomic) BaseButtonNode *button3;
@property (nonatomic) BaseButtonNode *button4;
@property (nonatomic) BaseButtonNode *button5;
@property (nonatomic) ASTableNode *tableNode;
@end

@implementation AssetsBlockNode

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _button1 = [BaseButtonNode standartButton];
        [_button1 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button1.backgroundColor = [UIColor redColor];
        [self addSubnode:_button1];
        
        _button2 = [BaseButtonNode standartButton];
        [_button2 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button2.backgroundColor = [UIColor greenColor];
        [self addSubnode:_button2];
        
        _button3 = [BaseButtonNode standartButton];
        [_button3 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button3.backgroundColor = [UIColor yellowColor];
        [self addSubnode:_button3];
        
        _button4 = [BaseButtonNode standartButton];
        [_button4 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button4.backgroundColor = [UIColor lightGrayColor];
        [self addSubnode:_button4];
        
        _button5 = [BaseButtonNode standartButton];
        [_button5 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button5.backgroundColor = [UIColor darkGrayColor];
        [self addSubnode:_button5];
        
        _tableNode = [ASTableNode new];
        _tableNode.flexShrink = YES;
        _tableNode.flexShrink = YES;
        _tableNode.alignSelf = ASStackLayoutAlignSelfStretch;
        [self addSubnode:_tableNode];
        
        self.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_button1, _button2, _button3, _button4, _button5]];
            spec.alignSelf = ASStackLayoutAlignSelfStretch;
            spec.flexBasis = ASRelativeDimensionMakeWithPoints(100);
            spec.alignItems = ASStackLayoutAlignItemsStart;
            
            ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[spec, _tableNode]];
            stackSpec.alignSelf = ASStackLayoutAlignSelfStretch;
            stackSpec.flexBasis = ASRelativeDimensionMakeWithPercent(1.0);
            stackSpec.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                     ASRelativeDimensionMakeWithPercent(1));
            
            ASStaticLayoutSpec *spec2 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[stackSpec]];
            return spec2;
        };
    }
    
    return self;
}


@end
