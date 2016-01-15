//
//  ViewController.m
//  LinkEmitter
//
//  Created by Stephen Kopylov - Home on 14/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import "ViewController.h"

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


- (IBAction)linkClicked:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"expertoption://deposit/bonus?code=GOLD&presetId=4"]];
}


@end
