//
//  SomeClass2.m
//  blocks
//
//  Created by Admin on 17.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SomeClass2.h"

@implementation SomeClass2
-(void)testFunction{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"async call");
        [self testFunction2];
    });
    NSLog(@"SomeClass2 testFunction");
}
-(void)testFunction2{
        NSLog(@"SomeClass2 testFunction2");
}
-(void)dealloc{
    NSLog(@"SomeClass2 dealloc");
}
@end
