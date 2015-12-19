#import "AppDelegate.h"
#import "ViewController.h"
#import "CustomChatViewController.h"
#import "ChatStyling.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self styleApp];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // Chat setup
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    // apply appearance styling first if you want to customise the look of the chat
    [ChatStyling applyStyling];
    
    // configure account key and pre-chat form
    [ZDCChat configure:^(ZDCConfig *defaults) {
        defaults.accountKey = @"3GWVlz4YyqBQb8oIzky6JCjyL0eTo3MA";
        defaults.preChatDataRequirements.name = ZDCPreChatDataOptionalEditable;
        defaults.preChatDataRequirements.email = ZDCPreChatDataOptionalEditable;
        defaults.preChatDataRequirements.phone = ZDCPreChatDataOptionalEditable;
        defaults.preChatDataRequirements.department = ZDCPreChatDataOptionalEditable;
        defaults.preChatDataRequirements.message = ZDCPreChatDataOptional;
    }];
    
    // To override the default avatar uncomment and complete the image name
    //[[ZDCChatAvatar appearance] setDefaultAvatar:@"your_avatar_name_here"];
    
    // Uncomment to disable visitor data persistence between application runs
    //[[ZDCChat instance].session visitorInfo].shouldPersist = NO;
    
    // Uncomment if you don't want open chat sessions to be automatically resumed on application launch
    //[ZDCChat instance].shouldResumeOnLaunch = NO;
    
    // remember to switch off debug logging before app store submission!
    [ZDCLog enable:YES];
    [ZDCLog setLogLevel:ZDCLogLevelWarn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // sample app boiler plate
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    
    // top view controller
    CustomChatViewController *vc = [[CustomChatViewController alloc] initWithNibName:nil bundle:nil];
    //ViewController *vc = [ViewController new];
    
    // nav controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // assign nav controller as root
    self.window.rootViewController = navController;
    
    // make key window
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)styleApp
{
    if ( [ZDUUtil isVersionOrNewer:@(7)] ) {
        // status bar
        // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        // nav bar
        //NSDictionary *navbarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                  [UIColor whiteColor] ,UITextAttributeTextColor, nil];
        //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        //[[UINavigationBar appearance] setTitleTextAttributes:navbarAttributes];
        //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.91f green:0.16f blue:0.16f alpha:1.0f]];
        
        if ( [ZDUUtil isVersionOrNewer:@(8)] ) {
            // For translucent nav bars set YES
            // [[UINavigationBar appearance] setTranslucent:NO];
        }
        
        // For a completely transparent nav bar uncomment this and set 'translucent' above to YES
        // (you may also want to change the title text and tint colors above since they are white by default)
        //[[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
        //[[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //[[UINavigationBar appearance] setShadowImage:[UIImage new]];
        //[[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    }
    else {
        // [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.91f green:0.16f blue:0.16f alpha:1.0f]];
    }
}


void uncaughtExceptionHandler(NSException *exception)
{
    [ZDCLog e:@"CRASH: %@", exception];
    [ZDCLog e:@"Stack Trace: %@", [exception callStackSymbols]];
}


@end
