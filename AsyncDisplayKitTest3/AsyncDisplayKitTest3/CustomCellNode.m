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
        
//        _textNode2 = [[ASTextNode alloc] init];
//        _textNode2.attributedString = [[NSAttributedString alloc] initWithString:@"asdasdas dasd asd asdasdasdasd asd asd asdasd as d"
//                                                                      attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor greenColor] }];
        [self addSubnode:_textNode];
//        [self addSubnode:_textNode2];
    }
    
    return self;
}


- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    ASStackLayoutSpec *hStack = [[ASStackLayoutSpec alloc] init];
    hStack.direction = ASStackLayoutDirectionHorizontal;
    hStack.flexGrow = NO;
//    hStack.flexShrink = YES;
    hStack.justifyContent = ASStackLayoutJustifyContentStart;
    hStack.alignItems = ASStackLayoutAlignItemsStart;
    [hStack setChildren:@[_textNode]];
    
    ASStackLayoutSpec *vStack = [[ASStackLayoutSpec alloc] init];
    vStack.direction = ASStackLayoutDirectionVertical;
    vStack.flexGrow = YES;
//    vStack.flexShrink = YES;
    vStack.justifyContent = ASStackLayoutJustifyContentStart;
    vStack.alignItems = ASStackLayoutAlignItemsStart;
    [vStack setChildren:@[hStack]];
    
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:vStack];
        insetSpec.flexGrow = YES;
    return insetSpec;
}


@end
