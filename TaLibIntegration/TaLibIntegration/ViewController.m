//
//  ViewController.m
//  TaLibIntegration
//
//  Created by Stephen Kopylov - Home on 02/09/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import "ObjCpp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjCpp *test = [ObjCpp new];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
