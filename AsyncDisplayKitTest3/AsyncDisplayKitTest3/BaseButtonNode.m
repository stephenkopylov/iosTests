//
//  BaseButtonNode.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 27/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "BaseButtonNode.h"
#import "UIView+Additions.h"

@implementation BaseButtonNode

- (void)setHighlighted:(BOOL)highlighted
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ( highlighted ) {
            [self.view animateDown];
        }
        else {
            [self.view animateUp];
        }
    });
}


@end
