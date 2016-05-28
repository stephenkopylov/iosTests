//
//  LayoutPlayground.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 27/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "LayoutPlayground.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
@interface LayoutPlayground ()
@property (nonatomic) ASDisplayNode *node;

@end

@implementation LayoutPlayground

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _node = [ASDisplayNode new];
    
    _node.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
    [self.view addSubnode:_node];
    
    ASDisplayNode *node1 = [ASDisplayNode new];
    node1.preferredFrameSize = CGSizeMake(100, 100);
    node1.backgroundColor = [UIColor redColor];
    node1.alignSelf = ASStackLayoutAlignSelfStretch;
    node1.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                         ASRelativeDimensionMakeWithPercent(1));
    
    [_node addSubnode:node1];
    
    ASDisplayNode *node2 = [ASDisplayNode new];
    node2.backgroundColor = [UIColor redColor];
    node2.alignSelf = ASStackLayoutAlignSelfStretch;
    node2.flexGrow = YES;
    node2.sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                         ASRelativeDimensionMakeWithPercent(1));
    [_node addSubnode:node2];
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        ASStaticLayoutSpec *spec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[node1]];
        spec.flexBasis = ASRelativeDimensionMakeWithPoints(30);
        
        ASStackLayoutSpec *stackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[spec, node2]];
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
