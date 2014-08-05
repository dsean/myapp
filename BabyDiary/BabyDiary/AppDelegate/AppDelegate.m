//
//  AppDelegate.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/8.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "AppDelegate.h"
#import "SatManager.h"
#import "AccountHandler.h"
#import "UserPreferences.h"


@interface AppDelegate ()

@property (nonatomic, copy) NSString *defaultsUsername;
@property (nonatomic, copy) NSString *defaultsPassword;
@property (nonatomic) BOOL isLogin;

@end

@implementation AppDelegate

#pragma mark-lifCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *licensePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"license"];
    [SatManager setLicensePath:licensePath];
    
    if ([self loginDefaultsAccount]) {
        // this is a blocking method
        self.isLogin = [AccountHandler login:self.defaultsUsername :self.defaultsPassword];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.isLogin) {
        [self.window.rootViewController performSegueWithIdentifier:@"loginSegue" sender:self.window.rootViewController];
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark-toolMethods

- (BOOL)loginDefaultsAccount {
    self.defaultsUsername = [[UserPreferences sharedUserPreferences] defaultsUsername];
    self.defaultsPassword = [[UserPreferences sharedUserPreferences] defaultsPassword];
    if (self.defaultsUsername == NULL || self.defaultsPassword == NULL) {
        return NO;
    }
    return YES;
}

@end
