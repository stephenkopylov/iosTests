//
//  PopupTestViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 01/06/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "PopupTestViewController.h"
#import "SimpleAsyncPopup.h"

@implementation PopupTestViewController
- (IBAction)buttonPressed:(id)sender
{
    SimpleAsyncPopup *popup = [SimpleAsyncPopup new];
    
    [popup show];
}


@end
