//
//  SatManager.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatManager.h"

@implementation SatManager
@synthesize userDeviceEntries, satServer, satServerPort, signalServer, signalServerPorts, satLoginBool;

static SatManager *_satManager;

-(id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    if (!_satManager) {
        _satManager = [SatManager alloc];
    }
    return _satManager;
}


-(NSMutableDictionary *)userDeviceEntries {
    if (!userDeviceEntries) {
        userDeviceEntries = [[NSMutableDictionary alloc] init];
    }
    return userDeviceEntries;
}

- (void)getSatRequest:(NSString *)username :(NSString *)password {
    p_sat_request = P2PFactory::CreateSATRequest([username UTF8String], [password UTF8String], p_license);
}

- (NSInteger)requestSatDevicesByServiceType:(NSString *)serviceType andDeviceType:(NSString *)deviceType {
    lastServiceType = serviceType;
    lastDeviceType = deviceType;
    
    // Get device list.
    const std::vector<DeviceEntry *> *deviceEntries = NULL;
    
    if (p_sat_request == NULL) {
            
        return -1;
    }
    int ret = -1;
    int getDeviceEntryListRetry = 0;
    while(getDeviceEntryListRetry < 2 && ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
            ret = p_sat_request->GetDeviceEntryList(&deviceEntries, [serviceType UTF8String], [deviceType UTF8String]);
            getDeviceEntryListRetry++;
    }
    //  to check deviceList
    //  int n = deviceEntries->size();
    
    if (ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
            

        return ret;
    }
    userDeviceEntries = [SatDevice parseMyDevices:deviceEntries];
    
    return 0;
}

- (void)getLicenseForSatLogin: (NSString *)licenseName {
    // Load license.
    NSString *licensePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:licenseName];
    
    p_license = P2PFactory::CreateLicense([licensePath UTF8String]);
    
    // Load license params.
    p_license->GetSATServer(sat_server, &sat_server_port);
    signal_server_ports_count = 3;   // !!!: Get signal server multi-ports x 3.
    p_license->GetSignalServer(signal_server, signal_server_ports, signal_server_ports_count);
    satServer = [NSString stringWithFormat:@"%s", sat_server];
    satServerPort = sat_server_port;
    signalServer = [NSString stringWithFormat:@"%s", signal_server];
    signalServerPorts = [[NSArray alloc] initWithObjects:@(signal_server_ports[0]), @(signal_server_ports[1]), @(signal_server_ports[2]), nil];
}

@end
