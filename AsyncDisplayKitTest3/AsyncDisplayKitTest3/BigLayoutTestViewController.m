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
    
    BaseButtonNode *button = [BaseButtonNode new];
    [button setTitle:@"123123" withFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
//    button.flexGrow = YES;
//    button.flexShrink = YES;
//    button.alignSelf = ASStackLayoutAlignSelfStretch;
    button.backgroundColor = [UIColor redColor];
    button.preferredFrameSize = CGSizeMake(10.0, 20);
    [button addTarget:self action:@selector(test) forControlEvents:ASControlNodeEventTouchUpInside];
    [_node addSubnode:button];
    
    BaseButtonNode *button2 = [BaseButtonNode new];
    [button2 setTitle:@"123123" withFont:[UIFont systemFontOfSize:15] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
    button2.flexGrow = YES;
//    button2.flexShrink = YES;
//    button2.alignSelf = ASStackLayoutAlignSelfStretch;
    button2.backgroundColor = [UIColor grayColor];
    button2.preferredFrameSize = CGSizeMake(10.0, 20);
    [_node addSubnode:button2];
    
    ASPagerNode *pagerNode = [ASPagerNode new];
    pagerNode.flexGrow = YES;
    pagerNode.flexShrink = YES;
    pagerNode.alignSelf = ASStackLayoutAlignSelfStretch;
    pagerNode.backgroundColor = [UIColor blueColor];
    [_node addSubnode:pagerNode];
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        
        button.sizeRange = ASRelativeSizeRangeMake(
                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(200), ASRelativeDimensionMakeWithPoints(40)),
                                                   ASRelativeSizeMake(ASRelativeDimensionMakeWithPoints(200), ASRelativeDimensionMakeWithPoints(40))
                                                   );
        
        ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
//        hStack.alignItems = ASStackLayoutAlignItemsCenter;
        [hStack setChildren:@[button, button2]];
        hStack.alignSelf = ASStackLayoutAlignSelfStretch;
  
//        hStack.flexGrow = YES;
//        hStack.flexShrink = YES;
        
        ASStackLayoutSpec *vStack = [ASStackLayoutSpec verticalStackLayoutSpec];
        [vStack setChildren:@[hStack, pagerNode]];
        //        vStack.alignItems = ASStackLayoutAlignItemsCenter;
        vStack.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                              ASRelativeDimensionMakeWithPercent(1));
        
        ASStaticLayoutSpec *staticLayoutSpec2 = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[vStack]];
        return staticLayoutSpec2;
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
