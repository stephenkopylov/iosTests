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
    NSLog(@"before");
    
    RLMMigrationBlock migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
            [migration enumerateObjects:RealmTestModel.className block:^(RLMObject *oldObject, RLMObject *newObject) {
                //newObject[@"dogs"] = nil;
            }];
    };
    
    [RLMRealm setDefaultRealmSchemaVersion:5 withMigrationBlock:migrationBlock];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        
        for ( int i = 0; i < 10000; i++ ) {
            RLMResults *results = [RealmTestModel allObjects];
            
            RealmTestModel *testModel = [RealmTestModel new];
            testModel.firstName = [NSString stringWithFormat:@"Stephen%lu", (unsigned long)results.count];
            testModel.date = [NSDate new];
            
            RealmTestModelDog *dog = [RealmTestModelDog new];
            dog.name = @"superDog";
            
            [testModel.dogs addObject:dog];
            
            [realm addObject:testModel];
        }
        
        [realm commitWriteTransaction];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            RLMResults *results = [RealmTestModel allObjects];
            RealmTestModel *model = (RealmTestModel *)results.lastObject;
            NSLog(@"name = %@", model.firstName);
            
            
            RealmTestModelDog *dog = (RealmTestModelDog*)model.dogs.lastObject;
            RealmTestModel *man = dog.owners.lastObject;
            
            NSLog(@"after %@",man.firstName);
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
