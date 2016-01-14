//
//  AppDelegate.m
//  OneSkyTest
//
//  Created by Stephen Kopylov - Home on 30/12/15.
//  Copyright © 2015 Stephen Kopylov - Home. All rights reserved.
//

#import "AppDelegate.h"
#import <OneSkyOTAPlugin/OneSkyOTAPlugin.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [OneSkyOTAPlugin setDebug:YES];
    [OneSkyOTAPlugin provideAPIKey:@"FDv5BpJDDyZf8wfpMbFmVdNMWK6Jh9bN"
                         APISecret:@"O9A4z74NcnZvLJH9rp6pKTHA1S6tXGdB"
                         projectID:@"53484"];
    [OneSkyOTAPlugin checkForUpdate];
    
    NSLog(@"testString = %@", OSLocalizedString(@"DEMO_ACCOUNT", @"test"));
    
   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       // NSLog(@"testString = %@", OSLocalizedString(@"DEMO_ACCOUNT", @"test"));
   //});
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
