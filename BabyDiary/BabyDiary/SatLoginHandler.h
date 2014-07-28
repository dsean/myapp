//
//  SatLoginHandler.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatManager.h"

@interface SatLoginHandler : NSObject {
    // SAT SDK
#ifdef __cplusplus
    IP2PLicense *p_license;
    IP2PSATRequest *p_sat_request;
    
    
    // SAT config
    char sat_server[1024];
    unsigned short sat_server_port;
    char signal_server[1024];
    unsigned short signal_server_ports[5];
    int signal_server_ports_count;
    
#endif
    
}


@property (strong, nonatomic) NSString *satServer;
@property (nonatomic) NSInteger satServerPort;
@property (strong, nonatomic) NSString *signalServer;
@property (strong, nonatomic) NSArray *signalServerPorts;
@property (nonatomic) BOOL satLoginBool;

- (void)prepardForSatLogin;
- (void)satLogin:(NSString *)satUsername :(NSString *)satPassword;
- (BOOL)checkLoginContent:(NSString*)username :(NSString*)password;
@end