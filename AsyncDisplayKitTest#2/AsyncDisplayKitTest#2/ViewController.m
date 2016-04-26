//
//  ViewController.m
//  AsyncDisplayKitTest#2
//
//  Created by Stephen Kopylov - Home on 01/04/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for ( int i = 0; i < 30; i++ ) {
            ASTextNode *node = [[ASTextNode alloc] init];
            node.attributedString = [[NSAttributedString alloc] initWithString:@"123123123" attributes:@{ NSForegroundColorAttributeName: [UIColor redColor] }];
            node.frame = CGRectMake(100, i, 100, 100);
            [self.view addSubview:node.view];
        }
    });
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
