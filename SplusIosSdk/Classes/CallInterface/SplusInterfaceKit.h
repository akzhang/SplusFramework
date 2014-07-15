//
//  SplusInterfaceKit.h
//  SplusIosSdk
//
//  Created by akzhang on 14-6-13.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplusCallback.h"
#import <UIKit/UIKit.h>

@interface SplusInterfaceKit : NSObject

@property(nonatomic,retain)id<SplusCallback> delegate;//设置callback委托

/**
 *  API单例
 *
 *  @return 返回单例
 */
+(SplusInterfaceKit*)sharedInstance;

/**
 *  设置委托
 *
 *  @param argDelegate 委托
 */
-(void)setDelegate:(id<SplusCallback>)argDelegate;

/**
 *  CP商渠道号，游戏ID，游戏ID，渠道号从Splus后台获取
 *
 *  @param AppId       游戏ID
 *  @param argSourceId 渠道ID
 *  @param argGameKey 游戏key
 */
-(void) setApp:(NSString*)AppId GameKey:(NSString*)argGameKey SourceID:(NSString*)argSourceId;

/**
 *  激活接口
 */
-(void)activate;


/**
 *  登录接口
 *
 *  @param context context
 */
-(void)splusLogin;

/**
 *  个人中心
 */
-(void)splusAcountManage;


/**
 *  不定额充值
 */
-(void)splusPay:(NSString*)type;

/**
 *  支付宝
 *
 *  @param paramURL 支付宝请求url
 */
- (void)alixPayResult:(NSURL *)paramURL;

/**
 *  定额支付
 *  @param money      充值金额
 */
-(void)splusQuotaPay:(NSString*)money Type:(NSString*)mType;


-(void)suspendView:(int)payway;

-(void)setPlayerInfo:(NSString*)serverid serverName:(NSString*)serverName RoleId:(NSString*)roleld RoleName:(NSString*)roleName OutOrderId:(NSString*)mOutOrderid Pext:(NSString*)mPext;

@end
