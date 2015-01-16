//
//  SomeClass.h
//  blocks
//
//  Created by Admin on 17.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SomeClass2.h"

@interface SomeClass : NSObject
-(void)testFunctionWithCallback:(void (^)(SomeClass2 *image))callback;
@property (nonatomic,strong) SomeClass2 *testClass;
@end
