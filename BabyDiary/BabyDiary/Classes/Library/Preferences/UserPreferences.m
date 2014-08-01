//
//  UserPreferences.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/8/1.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "UserPreferences.h"

@implementation UserPreferences

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

- (void)tosetUsername:(NSString *)username {
    
    [defaults setValue:username forKeyPath:@"username"];
    [defaults synchronize];
    _defaultsUsername = username;
}

- (void)tosetPassword:(NSString *)password {
    
    [defaults setValue:password forKeyPath:@"password"];
    [defaults synchronize];
    _defaultsPassword = password;
}

- (NSString *)togetUsername {
    
    defaults = [NSUserDefaults standardUserDefaults];
    _defaultsUsername = [defaults stringForKey:@"username"];
    return _defaultsUsername;
}

- (NSString *)togetPassword {
    
    defaults = [NSUserDefaults standardUserDefaults];
    _defaultsPassword = [defaults stringForKey:@"password"];
    return _defaultsPassword;
}
@end
