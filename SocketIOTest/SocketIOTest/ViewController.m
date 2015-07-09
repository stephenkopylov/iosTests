//
//  ViewController.m
//  SocketIOTest
//
//  Created by rovaev on 09.07.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "ViewController.h"
#import "SocketIOTest-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SocketIOClient *socket = [[SocketIOClient alloc] initWithSocketURL:@"localhost:8080" options:nil];
    
    [socket on:@"connect" callback:^(NSArray *data, void (^ack)(NSArray *)) {
        NSLog(@"socket connected");
    }];
    
    [socket on:@"currentAmount" callback:^(NSArray *data, void (^ack)(NSArray *)) {
        double cur = [[data objectAtIndex:0] floatValue];
        
        [socket emitWithAck:@"canUpdate" withItems:@[@(cur)]](0, ^(NSArray *data) {
            [socket emit:@"update" withItems:@[@{ @"amount": @(cur + 2.50) }]];
        });
        
        ack(@[@"Got your currentAmount, ", @"dude"]);
    }];
    
    [socket on:@"news" callback:^(NSArray *data, void (^ack)(NSArray *)) {
        NSLog(@"%@", data);
    }];
    
    [socket connect];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
