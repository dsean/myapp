//
//  SatManager.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatManager.h"

@interface SatManager ()

@property (nonatomic, copy) NSString *satUsername;
@property (nonatomic, copy) NSString *satPassword;

@end

@implementation SatManager
@synthesize satServer, satServerPort, signalServer, signalServerPorts, uidToSatDevices;

static NSString *_licensePath;
static SatManager *_satManager;

+ (void)setLicensePath:(NSString *)licensePath {
    _licensePath = licensePath;
}

+ (id)sharedSatManager {
    @synchronized(self) {
        if (_satManager == nil) {
            _satManager = [[SatManager alloc] init];
        }
    }
    return _satManager;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    [self loadLicense];
    return self;
}

- (void)loadLicense {
    p_license = P2PFactory::CreateLicense([_licensePath UTF8String]);
    
    // Load license params.
    p_license->GetSATServer(sat_server, &sat_server_port);
    signal_server_ports_count = 3;   // !!!: Get signal server multi-ports x 3.
    p_license->GetSignalServer(signal_server, signal_server_ports, signal_server_ports_count);
    satServer = [NSString stringWithFormat:@"%s", sat_server];
    satServerPort = sat_server_port;
    signalServer = [NSString stringWithFormat:@"%s", signal_server];
    signalServerPorts = [[NSArray alloc] initWithObjects:@(signal_server_ports[0]), @(signal_server_ports[1]), @(signal_server_ports[2]), nil];
}

- (void)startSatService:(NSString *)username :(NSString *)password {
    self.satUsername = username;
    self.satPassword = password;
    
    p_sat_request = P2PFactory::CreateSATRequest([username UTF8String], [password UTF8String], p_license);
}

- (BOOL)requestSatDevicesByServiceType:(NSString *)serviceType andDeviceType:(NSString *)deviceType {
    if (p_sat_request == NULL) {
        return NO;
    }
    
    int ret = -1;
    const std::vector<DeviceEntry *> *deviceEntries = NULL;
    int getDeviceEntryListRetry = 0;
    while(getDeviceEntryListRetry < 2 && ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
        ret = p_sat_request->GetDeviceEntryList(&deviceEntries, [serviceType UTF8String], [deviceType UTF8String]);
        getDeviceEntryListRetry++;
    }
    
    if (ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
        return NO;
    }
    
    uidToSatDevices = [SatDevice parseDeviceEntries:deviceEntries];
    return YES;
}

- (NSMutableDictionary *)uidToSatDevices {
    if (!uidToSatDevices) {
        uidToSatDevices = [[NSMutableDictionary alloc] init];
    }
    return uidToSatDevices;
}

@end
