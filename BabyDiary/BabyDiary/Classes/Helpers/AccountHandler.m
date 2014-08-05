//
//  LoginHandler.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//


#import "AccountHandler.h"

@implementation AccountHandler


+ (BOOL)validateUsername:(NSString *)username {
    // format: allow "a~z, A~Z, 0~9, - and _"
    if ([username length] < 4 || [username length] > 32) {
        return NO;
    }
    NSError *error = NULL;
    NSString *regexString = @"^[a-z0-9_-]+$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:username options:0 range:NSMakeRange(0, [username length])];
    if (numberOfMatches == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)validatePassword:(NSString *)password {
    // format: allow "a~z, A~Z, 0~9, - and _"
    if ([password length] < 4 || [password length] > 32) {
        return NO;
    }
    NSError *error = NULL;
    NSString *regexString = @"^[a-z0-9_-]+$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])];
    if (numberOfMatches == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)login:(NSString *)satUsername :(NSString *)satPassword {
    if ([AccountHandler validateUsername:satUsername] == NO ||
        [AccountHandler validatePassword:satPassword] == NO) {
        return NO;
    }

    SatManager *satManager = [SatManager sharedSatManager];
    [satManager startSatService:satUsername :satPassword];
    BOOL success = [satManager requestSatDevicesByServiceType:@"camera,nvr" andDeviceType:@"p2p"];
    if (success) {
        [self storageDefaultsAccount:satUsername :satPassword];
    }
    return success;
}

+ (BOOL)logout {
    [self storageDefaultsAccount:NULL :NULL];
    return YES;
}

+ (void)storageDefaultsAccount:(NSString *)satUsername :(NSString *)satPassword {
    [[UserPreferences sharedUserPreferences] setDefaultsUsername:satUsername];
    [[UserPreferences sharedUserPreferences] setDefaultsPassword:satPassword];
}

@end
