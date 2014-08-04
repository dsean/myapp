//
//  UserPreferences.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/8/1.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "UserPreferences.h"

@implementation UserPreferences

#define usernameKey @"username"
#define passwordKey @"password"

@synthesize defaultsUsername,defaultsPassword;

static UserPreferences *userPreferences;
static NSUserDefaults *defaults;

+ (id)sharedUserPreferences {
    @synchronized(self) {
        if (userPreferences == nil) {
            userPreferences = [[UserPreferences alloc] init];
        }
    }
    return userPreferences;
}

- (void)setDefaultsUsername:(NSString *)username {
    
    [defaults setValue:username forKeyPath:usernameKey];
    [defaults synchronize];
    defaultsUsername = username;
}

- (void)setDefaultsPassword:(NSString *)password {
    
    [defaults setValue:password forKeyPath:passwordKey];
    [defaults synchronize];
    defaultsPassword = password;
}

- (NSString *)defaultsUsername {
    
    defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:usernameKey];
}

- (NSString *)defaultsPassword {
    
    defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:passwordKey];
}

@end
