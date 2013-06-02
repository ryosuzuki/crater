//
//  nasaAppDelegate.m
//  crater
//
//  Created by Ryo Suzuki on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "nasaAppDelegate.h"

#import "nasaFirstViewController.h"
#import "nasaSecondViewController.h"
#import "nasaThirdViewController.h"

@implementation nasaAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.tabBarController.delegate = self;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *viewController1 = [[nasaFirstViewController alloc] initWithNibName:@"nasaFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[nasaSecondViewController alloc] initWithNibName:@"nasaSecondViewController" bundle:nil];
    UIViewController *viewController3 = [[nasaThirdViewController alloc] initWithNibName:@"nasaThirdViewController" bundle:nil];

    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, nil];
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    
    UITabBarItem *tbi = [self.tabBarController.tabBar.items objectAtIndex:0];
    tbi.title = @"Venus";
    UITabBarItem *tb2 = [self.tabBarController.tabBar.items objectAtIndex:1];
    tb2.title = @"Ganymede";
    UITabBarItem *tb3 = [self.tabBarController.tabBar.items objectAtIndex:2];
    tb3.title = @"Callisto";

    
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    NSLog(@"hoge");
    if(tabSelectedView != self.tabBarController)
    {
        NSLog(@"firstView");
    } else {
        NSLog(@"secondeView");
    }
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
