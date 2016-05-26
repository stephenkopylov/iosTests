//
//  CustomCellNode.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 25/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "CustomCellNode.h"

@interface CustomCellNode ()
@property (nonatomic, strong) ASTextNode *textNode;
@property (nonatomic, strong) ASTextNode *textNode2;
@end

static CGFloat kInsets = 15.0;

@implementation CustomCellNode

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _textNode = [[ASTextNode alloc] init];
        _textNode.attributedString = [[NSAttributedString alloc] initWithString:@"123123123123123123123123123123123123 123123123123123123"
                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor] }];
        _textNode.flexShrink = YES;
        _textNode.alignSelf = ASStackLayoutAlignSelfStretch;
        
        _textNode2 = [[ASTextNode alloc] init];
        _textNode2.attributedString = [[NSAttributedString alloc] initWithString:@"asdasdas dasd asd asdasdasdasd asd asd asda"
                                                                      attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor greenColor] }];
        _textNode2.alignSelf = ASStackLayoutAlignSelfStretch;
        _textNode2.flexShrink = YES;
        [self addSubnode:_textNode];
        [self addSubnode:_textNode2];
    }
    
    return self;
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    CGFloat maxWidth = constrainedSize.min.width / 100.0f * 30.0f;
    ASStaticLayoutSpec *_textNodeSpec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[_textNode]];
    
    _textNodeSpec.flexShrink = YES;
    
    ASRelativeDimension halfParent = ASRelativeDimensionMakeWithPoints(maxWidth);
    ASRelativeDimension fillParent = ASRelativeDimensionMakeWithPoints(200.0f);
    
    _textNode.sizeRange = ASRelativeSizeRangeMake(
                                                  ASRelativeSizeMake(halfParent, fillParent),
                                                  ASRelativeSizeMake(halfParent, fillParent)
                                                  );
    ASStaticLayoutSpec *staticSpec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[_textNode]];
    
    ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    [hStack setChildren:@[staticSpec, _textNode2]];
    
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:hStack];
    return insetSpec;
}


@end
