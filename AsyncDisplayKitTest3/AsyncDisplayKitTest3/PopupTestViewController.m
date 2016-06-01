//
//  PopupTestViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 01/06/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "PopupTestViewController.h"
#import "BaseAsyncPopup.h"

@implementation PopupTestViewController
- (IBAction)buttonPressed:(id)sender
{
    BaseAsyncPopup *popup = [BaseAsyncPopup new];
    
    [popup show];
}


@end
