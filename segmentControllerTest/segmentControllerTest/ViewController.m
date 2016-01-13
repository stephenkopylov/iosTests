//
//  ViewController.m
//  segmentControllerTest
//
//  Created by Stephen Kopylov - Home on 13/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "UISegmentedControl+Additions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _segmented1.tintColor = [UIColor redColor];
    [_segmented1 removeBorders];
    
    _segmented2.tintColor = [UIColor redColor];
    [_segmented2 removeBorders];
    
    _segmented4.titleTextColor = [UIColor redColor];
    _segmented4.titleTextColor = [UIColor redColor];
    _segmented4.backgroundColor = [UIColor clearColor];
    _segmented4.layer.borderColor = [UIColor greenColor].CGColor;
    _segmented4.layer.borderWidth = 0.5;
    _segmented4.segmentIndicatorBackgroundColor = [UIColor blueColor];
    
    [_segmented4 insertSegmentWithTitle:@"test" atIndex:0];
    [_segmented4 insertSegmentWithTitle:@"test2" atIndex:0];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
