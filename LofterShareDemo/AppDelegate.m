//
//  AppDelegate.m
//  LofterShareDemo
//
//  Created by wtndcs on 14-7-29.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import "AppDelegate.h"
#import "LofterSDK/LofterApi.h"
#import "ShareViewController.h"

@interface AppDelegate () <LofterApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ShareViewController *shareVc = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    self.window.rootViewController = shareVc;
    
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
    // 注册Identify，同时在URL Type中增加Identify，需要注意的是URL Type中为lofter+shareIdentify
    [LofterApi registerApp:@"shareIdentify"];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [LofterApi handleOpenURL:url delegate:self];
    return YES;
}

- (void)onReceiveResponse: (LofterBaseResp *)resp {
    NSLog(@"%d %@", resp.errCode, resp.errStr);
}
     
     
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
