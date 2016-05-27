//
//  BigLayoutTestViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 27/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "BigLayoutTestViewController.h"
#import "CustomDisplayNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "BaseButtonNode.h"

@interface BigLayoutTestViewController ()<ASPagerDataSource, ASPagerDelegate>
@property (nonatomic) ASDisplayNode *node;
@end

@implementation BigLayoutTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _node = [ASDisplayNode new];
    
    _node.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubnode:_node];
    
    //    BaseButtonNode *button = [BaseButtonNode new];
    //    [button setTitle:@"111111" withFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
    //        button.flexGrow = YES;
    //        button.flexShrink = YES;
    //    button.alignSelf = ASStackLayoutAlignSelfStretch;
    //    button.backgroundColor = [UIColor redColor];
    //    [button addTarget:self action:@selector(test) forControlEvents:ASControlNodeEventTouchUpInside];
    //    [_node addSubnode:button];
    //
    //    BaseButtonNode *button2 = [BaseButtonNode new];
    //    [button2 setTitle:@"3333" withFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
    //        button2.flexGrow = YES;
    //        button2.flexShrink = YES;
    //    button2.alignSelf = ASStackLayoutAlignSelfStretch;
    //    button2.backgroundColor = [UIColor purpleColor];
    //    [_node addSubnode:button2];
    //
    
    ASDisplayNode *node1 = [ASDisplayNode new];
    //    node1.flexGrow = YES;
    node1.flexShrink = YES;
    node1.alignSelf = ASStackLayoutAlignSelfStretch;
    node1.backgroundColor = [UIColor redColor];
    node1.preferredFrameSize = CGSizeMake(100, 100);
    [_node addSubnode:node1];
    
    //    ASDisplayNode *node2 = [ASDisplayNode new];
    //    node2.backgroundColor = [UIColor purpleColor];
    //    node2.flexGrow = YES;
    //    node2.flexShrink = YES;
    //    node2.alignSelf = ASStackLayoutAlignSelfStretch;
    //    [_node addSubnode:node2];
    //
    //
    //    ASPagerNode *pagerNode = [ASPagerNode new];
    //    pagerNode.flexGrow = YES;
    //    pagerNode.flexShrink = YES;
    //    pagerNode.alignSelf = ASStackLayoutAlignSelfStretch;
    //    pagerNode.backgroundColor = [UIColor blueColor];
    //    [_node addSubnode:pagerNode];
    
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        //        ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
        //        [hStack setChildren:@[node1, node2]];
        //        hStack.alignItems = ASStackLayoutAlignItemsCenter;
        //        hStack.flexGrow = YES;
        //        hStack.flexShrink = YES;
        //        hStack.alignSelf = ASStackLayoutAlignSelfStretch;
        
        
        //        ASStaticLayoutSpec *staticLayoutSpec1 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[node1]];
        //        staticLayoutSpec1.flexGrow = YES;
        //        staticLayoutSpec1.flexShrink = YES;
        //        staticLayoutSpec1.alignSelf = ASStackLayoutAlignSelfStretch;
        //        staticLayoutSpec1.sizeRange = ASRelativeSizeRangeMake(
        //                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(constrainedSize.min.width), ASRelativeDimensionMakeWithPoints(40.0f)),
        //                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(constrainedSize.min.width), ASRelativeDimensionMakeWithPoints(40.0f))
        //                                                   );
        
        //                ASStaticLayoutSpec *staticLayoutSpec3 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[staticLayoutSpec1]];
        
        //        ASStackLayoutSpec *vStack = [ASStackLayoutSpec verticalStackLayoutSpec];
        //        [vStack setChildren:@[staticLayoutSpec3, pagerNode]];
        //        vStack.alignItems = ASStackLayoutAlignItemsCenter;
        //        vStack.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
        //                                                                              ASRelativeDimensionMakeWithPercent(1));
        //
        //        ASStaticLayoutSpec *staticLayoutSpec2 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[vStack]];
        ASStaticLayoutSpec *staticLayoutSpec1 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[node1]];
        staticLayoutSpec1.alignSelf = ASStackLayoutAlignSelfStretch;
        staticLayoutSpec1.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                         ASRelativeDimensionMakeWithPercent(1));
        staticLayoutSpec1.flexGrow = YES;
        staticLayoutSpec1.flexShrink = YES;
        
        ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:node1];
        
        return staticLayoutSpec1;
    };
}


- (void)test
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _node.frame = self.view.frame;
    [_node measure:self.view.frame.size];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
