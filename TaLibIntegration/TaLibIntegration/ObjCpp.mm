//
//  ObjCpp.m
//  TaLibIntegration
//
//  Created by Stephen Kopylov - Home on 02/09/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ObjCpp.h"
#include "CppTest.hpp"

@interface ObjCpp()

@property (nonatomic) CppTest *test;

@end

@implementation ObjCpp

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        self.test = new CppTest();
    }
    
    return self;
}


@end
