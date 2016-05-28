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
#import "CustomNode.h"

@interface LayoutPlayground ()
@property (nonatomic) CustomNode *node;
@end

@implementation LayoutPlayground


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _node = [CustomNode new];
    
    _node.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
    [self.view addSubnode:_node];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _node.frame = self.view.frame;
    [_node measure:self.view.frame.size];
}


@end
