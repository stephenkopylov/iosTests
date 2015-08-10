//
//  ViewController.m
//  ViewControllerNibTest
//
//  Created by Stephen Kopylov - Home on 04.08.15.
//  Copyright (c) 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TestViewController *vc = [[TestViewController alloc] initWithNibName:@"VC2" bundle:nil];
        [self.view addSubview:vc.view];
        
        //[self presentViewController:vc animated:YES completion:nil];
    });

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
