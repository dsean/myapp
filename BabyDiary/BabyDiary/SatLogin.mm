//
//  SatLogin.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatLogin.h"
@interface SatLogin ()
@property (strong, nonatomic) SatManager *satManager;
@end
@implementation SatLogin
@synthesize satServer, satServerPort, signalServer, signalServerPorts, satLoginBool, myDeviceEntries;

-(SatManager *)satManager {
    if (!_satManager) {
        _satManager = [[SatManager alloc] init];
    }
    return _satManager;
}
- (void)prepard {
    
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

- (void)satLogin {
    NSString *username = @"qatest1";
    NSString *password = @"1234";
    
    p_sat_request = [self.satManager getSatRequest:username :password :p_license];
    int ret = [self.satManager requestSatDevicesByServiceType:@"camera,nvr" andDeviceType:@"p2p" :p_sat_request];
    
    self.myDeviceEntries = self.satManager.myDeviceEntries;
    ret != 0 ? satLoginBool = NO : satLoginBool = YES;
    
}
@end
