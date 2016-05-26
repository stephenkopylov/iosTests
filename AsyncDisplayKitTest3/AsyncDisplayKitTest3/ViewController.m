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

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    _tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain asyncDataFetching:YES];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.asyncDataSource = self;
    _tableView.asyncDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 30.0f;
    [self.view addSubview:_tableView];
    
    NSDictionary *views = @{
                            @"tv": _tableView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[tv]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv]|" options:0 metrics:nil views:views]];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [_tableView reloadData];
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
