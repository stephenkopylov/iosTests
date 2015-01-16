//
//  ViewController.m
//  blocks
//
//  Created by Admin on 17.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "SomeClass.h"

@interface ViewController (){
    SomeClass *testClass;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testClass = [[SomeClass alloc] init];
    for (int i = 0; i<10; i++) {
        [testClass testFunctionWithCallback:^(SomeClass2 *testObj) {
            NSLog(@"image = %@",testObj);
        }];
    }
    testClass = nil;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
