//
//  LayoutPlayground.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 27/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "LayoutPlayground.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "BaseButtonNode.h"
@interface LayoutPlayground ()<ASPagerNodeDataSource>
@property (nonatomic) ASDisplayNode *node;

@end

@implementation LayoutPlayground


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _node = [ASDisplayNode new];
    
    _node.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
    [self.view addSubnode:_node];
    
    BaseButtonNode *button1 = [BaseButtonNode new];
    button1.backgroundColor = [UIColor redColor];
    button1.flexGrow = YES;
    button1.alignSelf = ASStackLayoutAlignSelfStretch;
    [button1 addTarget:self action:@selector(test) forControlEvents:ASControlNodeEventTouchUpInside];
    [_node addSubnode:button1];
    
    BaseButtonNode *button2 = [BaseButtonNode new];
    button2.backgroundColor = [UIColor greenColor];
    button2.alignSelf = ASStackLayoutAlignSelfStretch;
    button2.flexGrow = YES;
    [button2 addTarget:self action:@selector(test) forControlEvents:ASControlNodeEventTouchUpInside];
    [_node addSubnode:button2];
    
    ASPagerNode *pagerNode = [ASPagerNode new];
    pagerNode.backgroundColor = [UIColor blueColor];
    pagerNode.alignSelf = ASStackLayoutAlignSelfStretch;
    pagerNode.flexGrow = YES;
    //    pagerNode.delegate = self;
    pagerNode.dataSource = self;
    [_node addSubnode:pagerNode];
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[button1, button2]];
        spec.alignSelf = ASStackLayoutAlignSelfStretch;
        spec.flexBasis = ASRelativeDimensionMakeWithPoints(50);
        
        ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[spec, pagerNode]];
        stackSpec.alignSelf = ASStackLayoutAlignSelfStretch;
        stackSpec.flexBasis = ASRelativeDimensionMakeWithPercent(1.0);
        stackSpec.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                 ASRelativeDimensionMakeWithPercent(1));
        
        ASStaticLayoutSpec *spec2 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[stackSpec]];
        return spec2;
    };
}


- (void)test
{
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _node.frame = self.view.frame;
    [_node measure:self.view.frame.size];
}


- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode
{
    return PagerNodePageCount;
}


- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index
{
    return ^{
        ASCellNode *cellNode = [ASCellNode new];
        cellNode.backgroundColor = OverViewASPagerNodeRandomColor();
        return cellNode;
    };
}


- (ASSizeRange)pagerNode:(ASPagerNode *)pagerNode constrainedSizeForNodeAtIndexPath:(NSIndexPath *)indexPath
{
    return ASSizeRangeMakeExactSize(pagerNode.frame.size);
}


static UIColor * OverViewASPagerNodeRandomColor()
{
    CGFloat hue = (arc4random() % 256 / 256.0);    //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
