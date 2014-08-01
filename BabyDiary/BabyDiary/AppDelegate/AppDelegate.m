//
//  AppDelegate.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/8.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "AppDelegate.h"
#import "SatManager.h"
#import "UserPreferences.h"
#import "LoginHandler.h"

@interface AppDelegate ()

@property (nonatomic, copy) NSString *defaultusername;
@property (nonatomic, copy) NSString *defaultpassword;
@property (nonatomic) BOOL checkDefaultValuesTiLogin;
@property (nonatomic) BOOL checkLoginStatus;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *licensePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"license"];
    [SatManager setLicensePath:licensePath];
    
    _defaultusername = [[UserPreferences sharedUserPreferences] togetUsername];
    _defaultpassword = [[UserPreferences sharedUserPreferences] togetPassword];
    if (_defaultusername == NULL || _defaultpassword == NULL) {
        _checkDefaultValuesTiLogin = NO;
    }
    else {
         _checkDefaultValuesTiLogin = YES;
        _checkLoginStatus = [LoginHandler satLogin:_defaultusername :_defaultpassword];
    }
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_checkDefaultValuesTiLogin) {
        if (_checkLoginStatus) {
            [self.window.rootViewController performSegueWithIdentifier:@"loginSegue" sender:self.window.rootViewController];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
