//
//  ViewController.m
//  ASTableViewUpdatesSample
//
//  Created by Stephen Kopylov - Home on 07/10/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import "ASTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClicked:(id)sender {
    ASTableViewController *tvc = [ASTableViewController new];
    [self presentViewController:tvc animated:YES completion:nil];
}

@end
