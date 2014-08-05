//
//  LoginHandler.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatManager.h"
#import "UserPreferences.h"

@interface AccountHandler : NSObject

+ (BOOL)validateUsername:(NSString *)username;
+ (BOOL)validatePassword:(NSString *)password;
+ (BOOL)login:(NSString *)satUsername :(NSString *)satPassword;
+ (BOOL)logout;


@end
