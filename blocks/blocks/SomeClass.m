//
//  SomeClass.m
//  blocks
//
//  Created by Admin on 17.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SomeClass.h"



@implementation SomeClass{
}

-(void)testFunctionWithCallback:(void (^)(SomeClass2 *))callback{
    self.testClass = [[SomeClass2 alloc] init];
    callback(self.testClass);
}
-(void)dealloc{
      NSLog(@"SomeClass dealloc");
}
@end
