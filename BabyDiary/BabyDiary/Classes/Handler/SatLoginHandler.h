//
//  SatLoginHandler.h
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/28.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SatManager.h"

@interface SatLoginHandler : NSObject 


@property (nonatomic) BOOL satLoginCheck;

- (void)satLogin:(NSString *)satUsername :(NSString *)satPassword;
- (BOOL)checkLoginContent:(NSString*)username :(NSString*)password;

@end