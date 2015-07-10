//
//  RealmTestModel.m
//  RealmTest
//
//  Created by Admin on 09.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "RealmTestModel.h"

@implementation RealmTestModel

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"firstName": @"defaultName", @"secondName": @"defaultSecondName" };
}


@end


@implementation RealmTestModelDog

+ (NSDictionary *)defaultPropertyValues
{
    return @{ @"name": @"defaultDogName" };
}

- (NSArray *)owners
{
    return [self linkingObjectsOfClass:@"RealmTestModel" forProperty:@"dogs"];
}


@end
