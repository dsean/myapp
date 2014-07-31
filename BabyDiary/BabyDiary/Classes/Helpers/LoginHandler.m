//
//  SatLoginHandler.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//


#import "LoginHandler.h"
@interface LoginHandler ()
@property (strong, nonatomic) SatManager *satManager;
@end
@implementation LoginHandler
@synthesize satLoginCheck;

- (SatManager *)satManager {
    if (!_satManager) {
        _satManager = [[SatManager alloc] init];
    }
    return _satManager;
}

- (void)satLogin:(NSString *)satUsername :(NSString *)satPassword {
    
    [self.satManager getSatRequest:satUsername :satPassword];
    
    int ret = [_satManager requestSatDevicesByServiceType:@"camera,nvr" andDeviceType:@"p2p"];

    satLoginCheck = ret != 0 ? NO : YES;
}

- (BOOL)checkLoginContent:(NSString*)username :(NSString*)password {
    // format: allow "a~z, A~Z, 0~9, - and _"
    NSString *strToCheckUsername = username;
    NSString *strToCheckPassword = password;
    if ([strToCheckUsername length] < 4 || [strToCheckUsername length] > 32 || [strToCheckPassword length] < 4 || [strToCheckPassword length] > 32) {
        return NO;
    }
    NSError *error = NULL;
    NSString *regexString = @"^[a-z0-9_-]+$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSInteger numberOfMatchesUseername = [regex numberOfMatchesInString:strToCheckUsername options:0 range:NSMakeRange(0, [strToCheckUsername length])];
    NSInteger numberOfMatchesPassword = [regex numberOfMatchesInString:strToCheckPassword options:0 range:NSMakeRange(0, [strToCheckPassword length])];
    
    if (numberOfMatchesUseername == 0 || numberOfMatchesPassword == 0) {
        return NO;
    }
    return YES;
}

@end
