//
//  ViewController2.m
//  blocks
//
//  Created by Admin on 17.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController2.h"
#import "SomeClass.h"
#import "SomeClass2.h"

@interface ViewController2 ()
@property (nonatomic) SomeClass *someTestProperty;
@property (nonatomic) SomeClass2 *someTestProperty2;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.someTestProperty = [[SomeClass alloc] init];
    self.someTestProperty2 = [[SomeClass2 alloc] init];
    NSLog(@"viewController loaded");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"async call");
        [self.someTestProperty2 testFunction];
        [self testFunction];
    });
    
    [self.someTestProperty testFunctionWithCallback:^(SomeClass2 *image) {
        [self testFunction];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testFunction{
    NSLog(@"testFunction");
}
-(void)dealloc{
    NSLog(@"view controller dealloc");
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
