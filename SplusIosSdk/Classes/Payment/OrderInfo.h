//
//  OrderInfo.h
//  SplusFramework
//
//  Created by akzhang on 14-7-1.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject

+ (OrderInfo *)sharedSingleton;

@property(nonatomic, assign)NSString *serverId;

@property(nonatomic, strong)NSString *serverName;

@property(nonatomic, assign)NSString *roleId;

@property(nonatomic, strong)NSString *roleName;

@property(nonatomic, strong)NSString *outOrderid;

@property(nonatomic, strong)NSString *pext;

@property(nonatomic, assign)NSString *money;

@property(nonatomic, assign)NSString *type;

@property(nonatomic, strong)NSString *transNum;

-(void)initWithType:(NSString*)mServerId serverName:(NSString*)mServerName RoleId:(NSString*)mRoleId RoleName:(NSString*)mRoleName OutOrderId:(NSString*)mOutOrderid Pext:(NSString*)mPext Money:(NSString*)mMoney Type:(NSString*)mType;

@end
