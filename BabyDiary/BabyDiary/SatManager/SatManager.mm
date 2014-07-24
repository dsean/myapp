//
//  SatManager.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatManager.h"

@implementation SatManager
@synthesize satPassword, satUsername, myDeviceEntries;

-(NSMutableDictionary *)myDeviceEntries {
    if (!myDeviceEntries) {
        myDeviceEntries = [[NSMutableDictionary alloc] init];
    }
    return myDeviceEntries;
}

- (NSInteger)requestSatDevicesByServiceType:(NSString *)serviceType andDeviceType:(NSString *)deviceType :(IP2PSATRequest *)p_sat_request {
    lastServiceType = serviceType;
    lastDeviceType = deviceType;
    
    // Get device list.
    const std::vector<DeviceEntry *> *deviceEntries = NULL;
    
    if (p_sat_request == NULL) {
            
        return -1;
    }
    int ret=-1;
    int getDeviceEntryListRetry=0;
    while(getDeviceEntryListRetry<2 && ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
            ret = p_sat_request->GetDeviceEntryList(&deviceEntries, [serviceType UTF8String], [deviceType UTF8String]);
            getDeviceEntryListRetry++;
    }
    //  to check deviceList
    //  int n = deviceEntries->size();
    
    if (ret != SAT_SDK_LIB_RET_NULL_SUCCESS){
            
        satUsername = @"";
        satPassword = @"";
        return ret;
    }
    myDeviceEntries = [SatDevice parseMyDevices:deviceEntries];
    
    return 0;
}



- (IP2PLicense *)getLisense:(NSString *)licenseName {
    NSString *licensePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:licenseName];
    
    return P2PFactory::CreateLicense([licensePath UTF8String]);
}

- (IP2PSATRequest *)getSatRequest:(NSString *)username :(NSString *)password :(IP2PLicense *)p_license {
    return P2PFactory::CreateSATRequest([username UTF8String], [password UTF8String], p_license);
}
@end
