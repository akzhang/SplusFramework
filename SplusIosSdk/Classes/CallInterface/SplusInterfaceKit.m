//
//  SplusInterfaceKit.m
//  SplusIosSdk
//
//  Created by akzhang on 14-6-13.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "SplusInterfaceKit.h"
#import "AppInfo.h"
#import "Activate.h"
#import "Login.h"
#import "PayHome.h"
#import "QutoPayHome.h"
#import "OrderInfo.h"
#import "AcountHome.h"

@implementation SplusInterfaceKit

__strong static SplusInterfaceKit *singleton = nil;

/**
 *  API单例
 *
 *  @return 返回单例
 */
+(SplusInterfaceKit*)sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        //singleton = [[self alloc] init];
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

/**
 *  设置委托
 *
 *  @param argDelegate 委托
 */
-(void)setDelegate:(id<SplusCallback>)argDelegate
{
    _delegate = argDelegate;
}

/**
 *  CP商渠道号，游戏ID，游戏ID，渠道号从Splus后台获取
 *
 *  @param AppId       游戏ID
 *  @param argSourceId 渠道ID
 *  @param argGameKey 游戏key
 */
-(void) setApp:(NSString*)AppId GameKey:(NSString*)argGameKey SourceID:(NSString*)argSourceId
{
    [AppInfo sharedSingleton].gameID = AppId;
    [AppInfo sharedSingleton].gameKey = argGameKey;
    [AppInfo sharedSingleton].sourceID = argSourceId;
}

/**
 *  激活接口
 */
-(void)activate
{
    Activate *active = [[Activate alloc] init];
    active.delegate = _delegate;//设置委托
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:active animated:NO completion:nil];
}

/**
 *  登录接口
 */
-(void)splusLogin
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Login *login = [[Login alloc] init];
    login.delegate = _delegate;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:login animated:YES ];
    
}


-(void)splusAcountManage:(NSString*) serverid ServerName:(NSString*)serverName Roleld:(NSString*)roleld RoleName:(NSString*)roleName
{
    [OrderInfo sharedSingleton].serverId = serverid;
    [OrderInfo sharedSingleton].serverName = serverName;
    [OrderInfo sharedSingleton].roleId = roleld;
    [OrderInfo sharedSingleton].roleName = roleName;
    
    AcountHome *acount = [[AcountHome alloc] init];
    acount.delegate = _delegate;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:acount animated:YES ];
}

/**
 *  支付
 */
-(void)splusPay:(NSString*) serverid ServerName:(NSString*)serverName Roleld:(NSString*)roleld RoleName:(NSString*)roleName OutOrderid:(NSString*)outOrderid Ext:(NSString*)pext Type:(NSString*)type
{
//    if ([ActivateInfo sharedSingleton].deviceno == nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    //初始化订单信息
    [[OrderInfo sharedSingleton] initWithType:serverid serverName:serverName RoleId:roleld RoleName:roleName OutOrderId:outOrderid Pext:pext Money:0 Type:type];
    
    PayHome *pay = [[PayHome alloc] init];
    pay.delegate = _delegate;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:pay animated:YES ];
    
}

/**
 *  定额支付
 *
 *  @return 定额支付
 */
-(void)splusQuotaPay:(NSString*) serverid ServerName:(NSString*)serverName Roleld:(NSString*)roleld RoleName:(NSString*)roleName OutOrderid:(NSString*)outOrderid Ext:(NSString*)pext Type:(NSString*)type Money:(NSString*)money;
{
    //初始化订单信息
    [[OrderInfo sharedSingleton] initWithType:serverid serverName:serverName RoleId:roleld RoleName:roleName OutOrderId:outOrderid Pext:pext Money:money Type:type];
    
    QutoPayHome *pay = [[QutoPayHome alloc] init];
    pay.delegate = _delegate;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:pay animated:YES ];
}


//支付宝
- (void)alixPayResult:(NSURL *)paramURL{
    NSLog(@"alipay back %@", paramURL);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finish" object:@"0"];
};

@end
