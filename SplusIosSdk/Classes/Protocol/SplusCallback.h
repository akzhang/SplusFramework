//
//  SplusCallback.h
//  SplusIosSdk
//
//  Created by akzhang on 14-6-13.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplusUser.h"

@protocol SplusCallback <NSObject>

-(void)SplusActivateOnSuccess;

-(void)SplusLoginOnSuccess:(SplusUser*)user;

-(void)SplusPayOnSuccess;

-(void)SplusLoginOutSuccess;

@end
