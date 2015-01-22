//
//  NotViewController.m
//  RotatingWindowTest
//
//  Created by Admin on 22.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NotViewController.h"

@interface NotViewController ()

@end

@implementation NotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testView];
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
