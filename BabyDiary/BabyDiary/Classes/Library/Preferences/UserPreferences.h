//
//  UserPreferences.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/8/1.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

@property (nonatomic, copy) NSString *defaultsUsername;
@property (nonatomic, copy) NSString *defaultsPassword;

+ (id)sharedUserPreferences;

@end
