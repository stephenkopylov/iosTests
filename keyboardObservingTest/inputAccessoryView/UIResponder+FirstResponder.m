//
//  UIResponder+FirstResponder.m
//  1f-messenger
//
//  Created by rovaev on 05.06.15.
//  Copyright (c) 2015 1forma. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak UIResponder *currentFirstResponder;

@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder
{
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}


- (void)findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}


@end
