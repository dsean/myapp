//
//  SatManager.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#include "sat_sdk_lib_config.h"
#include "sat_sdk_lib_debug.h"
#include "sat_sdk_lib_client.h"
#include "sat_sdk_lib_license.h"
#include "IP2PServiceMonitor.h"
#endif

#import "SatDevice.h"

@interface SatManager : NSObject {
#ifdef __cplusplus
    IP2PLicense *p_license;
    IP2PSATRequest *p_sat_request;

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
@property (strong, nonatomic) NSMutableDictionary *uidToSatDevices;

+ (void)setLicensePath:(NSString *)licensePath;
+ (id)sharedSatManager;

- (void)startSatService:(NSString *)username :(NSString *)password;
- (BOOL)requestSatDevicesByServiceType:(NSString *)serviceType andDeviceType:(NSString *)deviceType;

@end
