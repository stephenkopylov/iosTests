//
//  SimpleAsyncPopup.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 01/06/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SimpleAsyncPopup.h"

@implementation SimpleAsyncPopup {
    ASDisplayNode *_node1;
    ASTextNode *_node2;
}

- (void)fillNode:(ASDisplayNode *)node
{
    _node1 = [ASDisplayNode new];
    _node1.backgroundColor = [UIColor redColor];
    _node1.flexBasis = ASRelativeDimensionMakeWithPoints(20);
    [node addSubnode:_node1];
    
    _node2 = [ASTextNode new];
    _node2.attributedString = [[NSAttributedString alloc] initWithString:@"123123123123" attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [node addSubnode:_node2];
}


- (ASLayoutSpec *)specForNode
{
    ASStackLayoutSpec *stac = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0.0 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[_node1, _node2]];
    
    return [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[stac]];
}


@end
