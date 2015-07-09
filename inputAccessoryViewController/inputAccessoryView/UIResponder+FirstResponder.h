//
//  UIResponder+FirstResponder.h
//  1f-messenger
//
//  Created by rovaev on 05.06.15.
//  Copyright (c) 2015 1forma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FirstResponder)

+ (id)currentFirstResponder;

@end
