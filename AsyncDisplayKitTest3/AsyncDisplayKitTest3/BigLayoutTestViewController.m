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
    
    ASPagerNode *node3 = [ASPagerNode new];
    node3.backgroundColor = [UIColor redColor];
    node3.alignSelf = ASStackLayoutAlignSelfStretch;
    node3.flexGrow = YES;
    [_node addSubnode:node3];
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[button1, button2]];
        spec.alignSelf = ASStackLayoutAlignSelfStretch;
        spec.flexBasis = ASRelativeDimensionMakeWithPoints(50);
        
        ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[spec, node3]];
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
