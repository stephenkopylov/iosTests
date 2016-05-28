//
//  CustomNode.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 28/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "CustomNode.h"
#import "BaseButtonNode.h"

@interface CustomNode ()<ASPagerNodeDataSource>
@property (nonatomic) BaseButtonNode *button1;
@property (nonatomic) BaseButtonNode *button2;
@property (nonatomic) BaseButtonNode *button3;

@property (nonatomic) ASEditableTextNode *textNode;

@property (nonatomic) ASPagerNode *pagerNode;

@property (nonatomic) PagerNodePage page;
@end

@implementation CustomNode

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _button1 = [BaseButtonNode new];
        [_button1 setTitle:@"11111" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button1.backgroundColor = [UIColor redColor];
        _button1.pageNumber = PagerNodePageOne;
        _button1.preferredFrameSize = CGSizeMake(0, 0);
        _button1.alignSelf = ASStackLayoutAlignSelfStretch;
        [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:_button1];
        
        _button2 = [BaseButtonNode new];
        [_button2 setTitle:@"22222" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button2.backgroundColor = [UIColor greenColor];
        _button2.alignSelf = ASStackLayoutAlignSelfStretch;
        _button2.preferredFrameSize = CGSizeMake(0, 0);
        _button2.alignSelf = ASStackLayoutAlignSelfStretch;
        _button2.pageNumber = PagerNodePageTwo;
        [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:_button2];
        
        _button3 = [BaseButtonNode new];
        [_button3 setTitle:@"33333" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        _button3.backgroundColor = [UIColor purpleColor];
        _button3.alignSelf = ASStackLayoutAlignSelfStretch;
        _button3.pageNumber = PagerNodePageThree;
        [_button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
        _button3.flexGrow = NO;
        _button3.flexBasis = ASRelativeDimensionMakeWithPoints(50);
        [self addSubnode:_button3];
        
        _textNode = [ASEditableTextNode new];
        _textNode.backgroundColor = [UIColor lightGrayColor];
        _textNode.alignSelf = ASStackLayoutAlignSelfStretch;
        _textNode.flexGrow = YES;
        _textNode.flexShrink = YES;
        [self addSubnode:_textNode];
        
        _pagerNode = [ASPagerNode new];
        _pagerNode.backgroundColor = [UIColor blueColor];
        _pagerNode.alignSelf = ASStackLayoutAlignSelfStretch;
        _pagerNode.flexGrow = YES;
        _pagerNode.dataSource = self;
        [self addSubnode:_pagerNode];
        
        self.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
            NSArray *children;
            children = @[_button1, _button2, _button3, _textNode];
            
            if ( self.page != PagerNodePageThree ) {
                _button1.flexGrow = YES;
                _button1.flexShrink = YES;
                
                _button2.flexGrow = YES;
                _button2.flexShrink = YES;
                
                _textNode.flexGrow = NO;
                _textNode.flexShrink = NO;
                _textNode.flexBasis = ASRelativeDimensionMakeWithPercent(0.0f);
            }
            else {
                _button1.flexGrow = NO;
                _button1.flexShrink = NO;
                _button1.flexBasis = ASRelativeDimensionMakeWithPercent(0.0f);
                
                _button2.flexGrow = NO;
                _button2.flexShrink = NO;
                _button2.flexBasis = ASRelativeDimensionMakeWithPercent(0.0f);
                
                _textNode.flexGrow = YES;
                _textNode.flexShrink = YES;
            }
            
            ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:children];
            spec.alignSelf = ASStackLayoutAlignSelfStretch;
            spec.flexBasis = ASRelativeDimensionMakeWithPoints(50);
            spec.alignItems = ASStackLayoutAlignItemsStart;
            
            ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[spec, _pagerNode]];
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


- (void)buttonClicked:(BaseButtonNode *)button
{
    PagerNodePage page = button.pageNumber;
    
    if ( self.page == PagerNodePageThree && page == PagerNodePageThree ) {
        self.page = PagerNodePageTwo;
    }
    else {
        self.page = page;
    }
    
    button.backgroundColor = OverViewASPagerNodeRandomColor();
    [_pagerNode scrollToPageAtIndex:self.page animated:YES];
    
    [self transitionLayoutWithAnimation:YES shouldMeasureAsync:NO measurementCompletion:^{
    }];
}


static UIColor * OverViewASPagerNodeRandomColor()
{
    CGFloat hue = (arc4random() % 256 / 256.0);    //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


- (void)animateLayoutTransition:(id<ASContextTransitioning>)context
{
    CGRect button1EndFrame = [context finalFrameForNode:_button1];
    CGRect button2EndFrame = [context finalFrameForNode:_button2];
    CGRect button3EndFrame = [context finalFrameForNode:_button3];
    
    button1EndFrame.size.height = 50.0f;
    button2EndFrame.size.height = 50.0f;
    
    CGRect textStartFrame = [context initialFrameForNode:_textNode];
    textStartFrame.size.height = 50.0f;
    _textNode.frame = textStartFrame;
    CGRect textEndFrame = [context finalFrameForNode:_textNode];
    
    [UIView animateWithDuration:0.2f animations:^{
        _button1.frame = button1EndFrame;
        _button2.frame = button2EndFrame;
        _button3.frame = button3EndFrame;
        
        _textNode.frame = textEndFrame;
    }];
}


#pragma mark - pager

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


@end
