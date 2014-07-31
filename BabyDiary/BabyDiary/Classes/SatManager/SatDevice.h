//
//  SatDevice.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef __cplusplus
#include "sat_sdk_lib_config.h"
#include "sat_sdk_lib_license.h"
#endif
@interface SatDevice : NSObject
@property (nonatomic, copy) NSString *macAddress;
#ifdef __cplusplus
+ (NSMutableDictionary *)parseMyDevices:(const std::vector<DeviceEntry *> *)deviceEntries;
#endif

@end
