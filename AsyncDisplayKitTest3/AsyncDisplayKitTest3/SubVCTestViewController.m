//
//  SubVCTestViewController.m
//  AsyncDisplayKitTest3
//
//  Created by Stephen Kopylov - Home on 30/05/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SubVCTestViewController.h"
#import "SubVCTest2ViewController.h"

@interface SubVCTestViewController ()

@end

@implementation SubVCTestViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithNode:[ASDisplayNode new]];
    
    if ( self ) {
    }
    
    return self;
}


- (instancetype)init
{
    self = [super initWithNode:[ASDisplayNode new]];
    
    if ( self ) {
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.node.backgroundColor = [UIColor whiteColor];
    
    SubVCTest2ViewController *vc = [SubVCTest2ViewController new];
    vc.node.backgroundColor = [UIColor redColor];
    vc.node.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:vc.view];
    
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:vc];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
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
