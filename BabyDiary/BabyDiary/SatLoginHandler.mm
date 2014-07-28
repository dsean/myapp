//
//  SatLoginHandler.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//


#import "SatLoginHandler.h"
@interface SatLoginHandler ()
@property (strong, nonatomic) SatManager *satManager;
@end
@implementation SatLoginHandler
@synthesize satServer, satServerPort, signalServer, signalServerPorts, satLoginBool;

- (SatManager *)satManager {
    if (!_satManager) {
        _satManager = [[SatManager alloc] init];
    }
    return _satManager;
}

- (void)prepardForSatLogin {
    
    // Load license.
    
    p_license = [self.satManager getLisense:@"license"];
    
    // Load license params.
    p_license->GetSATServer(sat_server, &sat_server_port);
    signal_server_ports_count = 3;   // !!!: Get signal server multi-ports x 3.
    p_license->GetSignalServer(signal_server, signal_server_ports, signal_server_ports_count);
    satServer = [NSString stringWithFormat:@"%s", sat_server];
    satServerPort = sat_server_port;
    signalServer = [NSString stringWithFormat:@"%s", signal_server];
    signalServerPorts = [[NSArray alloc] initWithObjects:@(signal_server_ports[0]), @(signal_server_ports[1]), @(signal_server_ports[2]), nil];
}

- (void)satLogin:(NSString *)satUsername :(NSString *)satPassword {
    NSString *username = satUsername;
    NSString *password = satPassword;
    
    p_sat_request = [_satManager getSatRequest:username :password :p_license];
    int ret = [_satManager requestSatDevicesByServiceType:@"camera,nvr" andDeviceType:@"p2p" :p_sat_request];
    
    ret != 0 ? satLoginBool = NO : satLoginBool = YES;
    
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
