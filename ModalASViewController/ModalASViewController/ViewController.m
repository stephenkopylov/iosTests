//
//  ViewController.m
//  ModalASViewController
//
//  Created by Stephen Kopylov - Home on 24/06/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClicked:(id)sender
{
    ASViewController *vc = [[ASViewController alloc] initWithNode:[ASDisplayNode new]];
    
    vc.node.backgroundColor = [UIColor redColor];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}


@end
