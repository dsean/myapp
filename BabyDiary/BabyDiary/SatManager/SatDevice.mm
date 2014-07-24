//
//  SatDevice.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "SatDevice.h"

@interface SatDevice ()

@end

@implementation SatDevice
@synthesize macAddress;

+ (NSMutableDictionary *)parseMyDevices:(const std::vector<DeviceEntry *> *)deviceEntries {
    NSMutableDictionary *myDevicesMap = [[NSMutableDictionary alloc] init];
    
    if (deviceEntries == NULL) {
        return nil;
    }
    
    NSInteger nDeviceEntries = deviceEntries->size();
    for (int i = 0; i < nDeviceEntries; i++) {
        DeviceEntry *deviceEntry = (*deviceEntries)[i];
        NSString *deviceEntryUid = [NSString stringWithCString:deviceEntry->uid.c_str() encoding:[NSString defaultCStringEncoding]];
        
        // If the uid does not exist, allocate a new SatDevice.
        SatDevice *satDevice = [myDevicesMap objectForKey:deviceEntryUid];
        if (satDevice == nil) {
            satDevice = [[SatDevice alloc] init];
            satDevice.macAddress = [NSString stringWithCString:deviceEntry->mac_address.c_str() encoding:[NSString defaultCStringEncoding]];
            // Collect SatDevice.
            [myDevicesMap setObject:satDevice forKey:deviceEntryUid];
        }
        
    }
    
    return myDevicesMap;
}
@end
