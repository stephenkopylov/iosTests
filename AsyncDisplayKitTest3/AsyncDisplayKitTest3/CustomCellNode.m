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
@property (nonatomic, strong) ASTextNode *textNode3;
@end

@implementation CustomCellNode

#define defaultFontSize 14

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _textNode = [[ASTextNode alloc] init];
        _textNode.maximumNumberOfLines = 1;
        _textNode.truncationMode = NSLineBreakByTruncatingTail;
        _textNode.alignSelf = ASStackLayoutAlignSelfCenter;
        _textNode.attributedString = [[NSAttributedString alloc] initWithString:@"1231231231231231231231"
                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor] }];
        _textNode.flexShrink = YES;
        
        _textNode2 = [[ASTextNode alloc] init];
        _textNode2.maximumNumberOfLines = 1;
        _textNode2.alignSelf = ASStackLayoutAlignSelfCenter;
        _textNode2.attributedString = [[NSAttributedString alloc] initWithString:@"asdasdas dasd asd asdasdasdasd asd asd asda"
                                                                      attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor greenColor] }];
        _textNode2.flexShrink = YES;
        
        _textNode3 = [[ASTextNode alloc] init];
        _textNode3.maximumNumberOfLines = 1;
        _textNode3.attributedString = [[NSAttributedString alloc] initWithString:@"asdasdas dasd asd asdasdasdasd asd asd asda"
                                                                      attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blueColor] }];
        _textNode3.flexShrink = YES;
        
        [self addSubnode:_textNode];
        [self addSubnode:_textNode2];
        [self addSubnode:_textNode3];
    }
    
    return self;
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    CGFloat _textNodeMaxWidth = constrainedSize.min.width / 100.0f * 30.0f;
    CGFloat fontSize = defaultFontSize;
    
    while ( [_textNode calculateSizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width > _textNodeMaxWidth ) {
        fontSize--;
        _textNode.attributedString = [[NSAttributedString alloc] initWithString:@"1231231231231231231231"
                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName: [UIColor blackColor] }];
    }
    
    CGSize size = [_textNode calculateSizeThatFits:CGSizeMake(_textNodeMaxWidth, MAXFLOAT)];
    _textNode.sizeRange = ASRelativeSizeRangeMake(
                                                  ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(_textNodeMaxWidth), ASRelativeDimensionMakeWithPoints(size.height)),
                                                  ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(_textNodeMaxWidth), ASRelativeDimensionMakeWithPoints(size.height))
                                                  );
    ASStaticLayoutSpec *textNodeStaticSpec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[_textNode]];
    
//    ASCenterLayoutSpec *textNodeCenter = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:textNodeStaticSpec];
    
    CGFloat _textNode3MaxWidth = constrainedSize.min.width / 100.0f * 20.0f;
    size = [_textNode3 calculateSizeThatFits:CGSizeMake(_textNode3MaxWidth, MAXFLOAT)];
    
    _textNode3.sizeRange = ASRelativeSizeRangeMake(
                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(_textNode3MaxWidth), ASRelativeDimensionMakeWithPoints(size.height)),
                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(_textNode3MaxWidth), ASRelativeDimensionMakeWithPoints(size.height))
                                                   );
    ASStaticLayoutSpec *textNode3StaticSpec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[_textNode3]];
    
    
    ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    hStack.alignItems = ASStackLayoutAlignItemsCenter;
    [hStack setChildren:@[textNodeStaticSpec, _textNode2, textNode3StaticSpec]];
    
    //    ASStackLayoutSpec *vStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    //    vStack.alignItems = ASStackLayoutAlignItemsCenter;
    //    [vStack setChildren:@[hStack]];
    
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:hStack];
    return insetSpec;
}


@end
