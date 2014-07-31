//
//  SatDevice.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatDevice.h"

@implementation SatDevice
@synthesize macAddress;

+ (NSMutableDictionary *)parseDeviceEntries:(const std::vector<DeviceEntry *> *)deviceEntries {
    if (deviceEntries == NULL) {
        return nil;
    }
    
    NSMutableDictionary *uidToSatDevices = [[NSMutableDictionary alloc] init];
    NSInteger nDeviceEntries = deviceEntries->size();
    for (int i = 0; i < nDeviceEntries; i++) {
        DeviceEntry *deviceEntry = (*deviceEntries)[i];
        NSString *uid = [NSString stringWithCString:deviceEntry->uid.c_str() encoding:[NSString defaultCStringEncoding]];
        
        // If the uid does not exist, allocate a new SatDevice.
        SatDevice *satDevice = [uidToSatDevices objectForKey:uid];
        if (satDevice == nil) {
            satDevice = [[SatDevice alloc] init];
            satDevice.macAddress = [NSString stringWithCString:deviceEntry->mac_address.c_str() encoding:[NSString defaultCStringEncoding]];
            
            // Collect SatDevice.
            [uidToSatDevices setObject:satDevice forKey:uid];
        }
        
    }
    
    return uidToSatDevices;
}

@end
