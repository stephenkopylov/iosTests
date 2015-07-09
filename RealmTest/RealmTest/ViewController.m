//
//  ViewController.m
//  RealmTest
//
//  Created by Admin on 09.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "RealmTestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        for ( int i = 0; i < 1000; i++ ) {
            // You only need to do this once (per thread)
            RLMResults *results = [RealmTestModel allObjects];
            
            RealmTestModel *testModel = [RealmTestModel new];
            testModel.name = [NSString stringWithFormat:@"Stephen%lu", (unsigned long)results.count];
            
            // Add to Realm with transaction
            
            [realm addObject:testModel];
        }
        
        [realm commitWriteTransaction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            RLMRealm *realm = [RLMRealm defaultRealm];
            RLMResults *results = [RealmTestModel allObjects];
            RealmTestModel *model = (RealmTestModel *)results.lastObject;
            NSLog(@"name = %@", model.name);
        });
    });
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
