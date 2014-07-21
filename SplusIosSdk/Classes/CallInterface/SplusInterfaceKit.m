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
#import "AcountWeb.h"

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

-(void)setPlayerInfo:(NSString*)serverid serverName:(NSString*)serverName RoleId:(NSString*)roleld RoleName:(NSString*)roleName OutOrderId:(NSString*)mOutOrderid Pext:(NSString*)mPext
{
    [OrderInfo sharedSingleton].serverId = serverid;
    [OrderInfo sharedSingleton].serverName = serverName;
    [OrderInfo sharedSingleton].roleId = roleld;
    [OrderInfo sharedSingleton].roleName = roleName;
    [OrderInfo sharedSingleton].outOrderid = mOutOrderid;
    [OrderInfo sharedSingleton].pext = mPext;
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
    [rootViewController presentModalViewController:login animated:NO];
    
}


-(void)splusAcountManage
{
    AcountHome *acount = [[AcountHome alloc] init];
    acount.delegate = _delegate;
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentModalViewController:acount animated:YES ];
}

/**
 *  支付
 */
-(void)splusPay:(NSString*)type
{
    if ([ActivateInfo sharedSingleton].deviceno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请先激活" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [OrderInfo sharedSingleton].type = type;
    
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
-(void)splusQuotaPay:(NSString*)money Type:(NSString*)mType
{
    [OrderInfo sharedSingleton].type = mType;
    [OrderInfo sharedSingleton].money = money;
    NSLog(@"moneyllllllllll=%@",[OrderInfo sharedSingleton].money);
    
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

-(void)suspendView:(int)payway
{
    if (payway == 4)
    {
        AcountHome *acount = [[AcountHome alloc] init];
        acount.delegate = _delegate;
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [rootViewController presentModalViewController:acount animated:YES ];
    }else
    {
        AcountWeb *acount = [[AcountWeb alloc] init];
        acount.payway = payway;
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [rootViewController presentModalViewController:acount animated:YES ];
    }
}






@end
