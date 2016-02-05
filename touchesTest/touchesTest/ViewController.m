//
//  ViewController.m
//  touchesTest
//
//  Created by Stephen Kopylov - Home on 05/02/16.
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
    self.view.multipleTouchEnabled = YES;
    // Dispose of any resources that can be recreated.
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    NSSet *currentTouches = [event touchesForView:self.view];
    NSSet *currentTouches = event.allTouches;
    
    NSLog(@"touches number %@", @(currentTouches.count));
    NSLog(@"------------------------");
    
    for ( UITouch *touch in currentTouches ) {
        NSLog(@"point = %@", NSStringFromCGPoint([touch locationInView:self.view]));
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *currentTouches = event.allTouches;
    
    NSLog(@"touches edned %@", @(currentTouches.count));
}


@end
