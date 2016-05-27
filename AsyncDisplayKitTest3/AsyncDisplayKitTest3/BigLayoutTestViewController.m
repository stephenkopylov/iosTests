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

@interface BigLayoutTestViewController ()
@property (nonatomic) ASDisplayNode *node;
@property (nonatomic) ASDisplayNode *button;
@property (nonatomic) ASDisplayNode *button2;
@end

@implementation BigLayoutTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _node = [ASDisplayNode new];
    
    _node.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubnode:_node];
    
    _button = [ASDisplayNode new];
    _button.flexGrow = YES;
    _button.flexShrink = YES;
    _button.alignSelf = ASStackLayoutAlignSelfStretch;
    _button.backgroundColor = [UIColor redColor];
    _button.frame = CGRectMake(0, 0, 100, 100);
    _button.preferredFrameSize = CGSizeMake(10.0, 20);
    [_node addSubnode:_button];
    
    _button2 = [ASDisplayNode new];
    _button2.flexGrow = YES;
    _button2.flexShrink = YES;
    _button2.backgroundColor = [UIColor grayColor];
    _button2.alignSelf = ASStackLayoutAlignSelfStretch;
    _button2.preferredFrameSize = CGSizeMake(10.0, 20);
    [_node addSubnode:_button2];
    
    _node.layoutSpecBlock = ^ASLayoutSpec *(ASDisplayNode *_Nonnull node, ASSizeRange constrainedSize) {
        ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
        hStack.alignItems = ASStackLayoutAlignItemsCenter;
        hStack.spacing = 5.0;
        [hStack setChildren:@[_button, _button2]];
        ASRelativeSizeRange sizeRange = ASRelativeSizeRangeMakeWithExactRelativeDimensions(ASRelativeDimensionMakeWithPercent(1),
                                                                                           ASRelativeDimensionMakeWithPercent(1));
        hStack.sizeRange = sizeRange;
        
          ASStaticLayoutSpec *staticLayoutSpec = [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[hStack]];
        
        return staticLayoutSpec;
    };
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
