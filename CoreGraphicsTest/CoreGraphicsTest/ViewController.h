//
//  ViewController.h
//  CoreGraphicsTest
//
//  Created by Stephen Kopylov - Home on 02.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphicsTest.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet CoreGraphicsTest *testView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

