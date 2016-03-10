//
//  TestView.m
//  OAStackViewTest
//
//  Created by Stephen Kopylov - Home on 05/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)init
{
    self = [super init];
    
    if ( self ) {
        _label = [UIView new];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        //_label.numberOfLines = 0;
        [self addSubview:_label];
        
        NSDictionary *views = @{
                                @"label": _label
                                };
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[label]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:views]];
    }
    
    return self;
}


@end
