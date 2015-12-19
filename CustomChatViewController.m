//
//  CustomChatViewController.m
//  ChatTest
//
//  Created by Stephen Kopylov - Home on 19/12/15.
//  Copyright © 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "CustomChatViewController.h"
#import <ZDCChat/ZDCChat.h>

@interface CustomChatViewController ()

@end

@implementation CustomChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [testButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    testButton.layer.cornerRadius = 5.0f;
    testButton.layer.borderWidth = 1.0f;
    testButton.layer.borderColor = [testButton tintColor].CGColor;
    [testButton setTitle:@"Open Chat" forState:UIControlStateNormal];
    testButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:testButton];
    
    NSDictionary *views = @{
                            @"button": testButton,
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[button]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[button(50)]" options:0 metrics:nil views:views]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonTapped
{
    [ZDCChat updateVisitor:^(ZDCVisitorInfo *visitor) {
        visitor.phone = [NSString stringWithFormat:@"%lu", (long)[[NSDate date] timeIntervalSince1970]];
        visitor.name = [NSString stringWithFormat:@"iOs Chat Test %lu", (long)[[NSDate date] timeIntervalSince1970]];
        visitor.email = [NSString stringWithFormat:@"chattest+%lu@test.com", (long)[[NSDate date] timeIntervalSince1970]];
    }];
    
    // start a chat in a new modal
    //[ZDCChat startChat:nil];
    [ZDCChat startChat:^(ZDCSessionConfig *config) {
        config.preChatDataRequirements.name = ZDCPreChatDataNotRequired;
        config.preChatDataRequirements.email = ZDCPreChatDataNotRequired;
        config.preChatDataRequirements.phone = ZDCPreChatDataNotRequired;
        config.preChatDataRequirements.department = ZDCPreChatDataNotRequired;
        config.preChatDataRequirements.message = ZDCPreChatDataNotRequired;
    }];
    /*
     [ZDCChat startChatIn:self.navigationController withConfig:^(ZDCSessionConfig *config) {
     config.preChatDataRequirements.name = ZDCPreChatDataNotRequired;
     config.preChatDataRequirements.email = ZDCPreChatDataNotRequired;
     config.preChatDataRequirements.phone = ZDCPreChatDataNotRequired;
     config.preChatDataRequirements.department = ZDCPreChatDataNotRequired;
     config.preChatDataRequirements.message = ZDCPreChatDataNotRequired;
     }];
     
     */
}


@end
