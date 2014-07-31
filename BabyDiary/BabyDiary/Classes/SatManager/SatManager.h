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
    NSString *lastServiceType;
    NSString *lastDeviceType;
}


@property (strong, nonatomic) NSMutableDictionary *userDeviceEntries;


#ifdef __cplusplus
- (NSInteger)requestSatDevicesByServiceType:(NSString *)serviceType andDeviceType:(NSString *)deviceType :(IP2PSATRequest *)p_sat_request;
- (IP2PLicense *)getLisense:(NSString *)licenseName;
- (IP2PSATRequest *)getSatRequest:(NSString *)username :(NSString *)password :(IP2PLicense *)p_license;

#endif

@end
