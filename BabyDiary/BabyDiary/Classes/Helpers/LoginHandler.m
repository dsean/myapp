//
//  LoginHandler.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//


#import "LoginHandler.h"

@implementation LoginHandler

#pragma mark-checkInput

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

#pragma mark-userLogin

+ (BOOL)login:(NSString *)satUsername :(NSString *)satPassword {
    if ([LoginHandler validateUsername:satUsername] == NO ||
        [LoginHandler validatePassword:satPassword] == NO) {
        return NO;
    }

    SatManager *satManager = [SatManager sharedSatManager];
    [satManager startSatService:satUsername :satPassword];
    BOOL success = [satManager requestSatDevicesByServiceType:@"camera,nvr" andDeviceType:@"p2p"];
    if (success) {
        [self rewriteDefaultValues:satUsername :satPassword];
    }
    return success;
}

+ (void)rewriteDefaultValues:(NSString *)satUsername :(NSString *)satPassword {
    [[UserPreferences sharedUserPreferences] setDefaultsUsername:satUsername];
    [[UserPreferences sharedUserPreferences] setDefaultsPassword:satPassword];
}

#pragma mark-userLogout

+ (BOOL)logout {
    [[UserPreferences sharedUserPreferences] setDefaultsUsername:NULL];
    [[UserPreferences sharedUserPreferences] setDefaultsPassword:NULL];
    return YES;
}

@end
