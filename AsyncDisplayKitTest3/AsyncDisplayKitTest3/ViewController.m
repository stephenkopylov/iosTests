//
//  ViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 25/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import "CustomCellNode.h"

@interface ViewController () <ASTableViewDataSource, ASTableViewDelegate>
@property (nonatomic) ASDisplayNode *dNode;
@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    _dNode = [ASDisplayNode new];
    _dNode.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_dNode.view];
    
    _tableView = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.view.rowHeight = 30.0f;
    [self.dNode addSubnode:_tableView];
    
    _tableView.frame = CGRectMake(0, 0, 400, 400);
    
    NSDictionary *views = @{
                            @"node": self.dNode.view
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[node]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[node]|" options:0 metrics:nil views:views]];
}


- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellNode *textCellNode = [CustomCellNode new];
    
    return textCellNode;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


@end
