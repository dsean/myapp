//
//  AppDelegate.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/8.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "AppDelegate.h"
#import "SatManager.h"
#import "LoginHandler.h"
#import "UserPreferences.h"


@interface AppDelegate ()

@property (nonatomic, copy) NSString *defaultusername;
@property (nonatomic, copy) NSString *defaultpassword;
@property (nonatomic) BOOL isLogin;

@end

@implementation AppDelegate

#pragma mark-lifCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *licensePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"license"];
    [SatManager setLicensePath:licensePath];
    
    if ([self hasAccount]) {
        // this is a blocking method
        self.isLogin = [LoginHandler satLogin:_defaultusername :_defaultpassword];
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

- (BOOL)hasAccount {
    self.defaultusername = [[UserPreferences sharedUserPreferences] defaultsUsername];
    self.defaultpassword = [[UserPreferences sharedUserPreferences] defaultsPassword];
    if (_defaultusername == NULL || _defaultpassword == NULL) {
        return NO;
    }
    return YES;
}

@end
