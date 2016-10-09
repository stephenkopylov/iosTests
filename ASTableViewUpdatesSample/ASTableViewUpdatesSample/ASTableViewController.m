//
//  ASTableViewController.m
//  ASTableViewUpdatesSample
//
//  Created by Stephen Kopylov - Home on 07/10/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ASTableViewController.h"
#import <Realm.h>
#import "TestModel.h"

@interface ASTableViewController ()<ASTableViewDelegate, ASTableViewDataSource>
@property (nonatomic) ASTableNode *tableNode;
@property (nonatomic) RLMResults *results;
@property (nonatomic) RLMNotificationToken *notificationToken;
@property (nonatomic) dispatch_queue_t customQueue;
@end

@implementation ASTableViewController

- (instancetype)init
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    self = [self initWithNode:tableNode];
    if (self) {
        _customQueue = dispatch_queue_create("CustomQueue", 0);
        
        self.node.backgroundColor = [UIColor greenColor];
        _tableNode = tableNode;
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        
        _results = [TestModel allObjects];
        
        __weak typeof(self) weakSelf = self;
        
        _notificationToken = [_results addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
            __strong  typeof(self) strongSelf = weakSelf;
            
            if(change){
                [strongSelf.tableNode.view beginUpdates];
                
                [strongSelf.tableNode.view insertRowsAtIndexPaths:[change insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                [strongSelf.tableNode.view deleteRowsAtIndexPaths:[change deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [strongSelf.tableNode.view endUpdates];
            }else{
                [strongSelf.tableNode.view reloadData];
            }
        }];
        
        [self update];
    }
    return self;
}


-(void)update{
    dispatch_async(_customQueue, ^{
        if([self randomBool]){
            [[RLMRealm defaultRealm] beginWriteTransaction];
            [[RLMRealm defaultRealm] deleteObjects:[TestModel allObjects]];
            [[RLMRealm defaultRealm] commitWriteTransaction];
        }else{
            int lowerBound = 0;
            int upperBound = 200;
            int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
            
            NSMutableArray *generatedObjects = @[].mutableCopy;
            
            for (int i = 0; i<rndValue; i++) {
                TestModel *model = [TestModel new];
                model.objectId = i;
                [generatedObjects addObject:model];
            }
            
            [[RLMRealm defaultRealm] beginWriteTransaction];
            [[RLMRealm defaultRealm] addOrUpdateObjectsFromArray:generatedObjects.copy];
            [[RLMRealm defaultRealm] commitWriteTransaction];
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.tableNode.view.contentOffset = CGPointMake(0.0f,self.tableNode.view.contentSize.height*drand48());
        
        [self update];
    });
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _results.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestModel *object = self.results[indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"ObjectId = %@",@(object.objectId)];
    
    return ^{
        ASTextCellNode *cell = [ASTextCellNode new];
        
        cell.text = title;
        
        return cell;
    };
}

-(BOOL)randomBool{
    int tmp = (arc4random() % 30)+1;
    if(tmp % 5 == 0){
        return YES;
    }else{
        return NO;
    }
}

@end
