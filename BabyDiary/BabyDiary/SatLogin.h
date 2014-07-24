//
//  SatLogin.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatManager.h"

@interface SatLogin : NSObject {
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

@property (nonatomic, copy, readonly) NSString *satServer;
@property (nonatomic, assign, readonly) NSInteger satServerPort;
@property (nonatomic, copy, readonly) NSString *signalServer;
@property (nonatomic, retain, readonly) NSArray *signalServerPorts;
@property (nonatomic) BOOL satLoginBool;
@property (strong, nonatomic) NSMutableDictionary *myDeviceEntries;
- (void)prepard;
- (void)satLogin;
@end
