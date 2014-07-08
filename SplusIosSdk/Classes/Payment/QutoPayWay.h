//
//  QutoPayWay.h
//  SplusFramework
//
//  Created by akzhang on 14-7-4.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
#import "CoinRatio.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "MBProgressHUD.h"
#import "httpRequest.h"
#import "CoinRatio.h"
#import "SBJsonParser.h"
#import "AlixPay.h"
#import "OrderInfo.h"
#import "JSON.h"
#import "SplusUser.h"
#import "UPPayPluginDelegate.h"
#import "UPPayPlugin.h"
#import "PayWebView.h"

@interface QutoPayWay : UIViewController

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign)int payway;

@property(nonatomic, strong)NSString *paySource;

@property(nonatomic, strong)UIView *splusMiddleFrame;

@property(nonatomic, strong)UILabel *splusCashValue;//充值金额

//元宝兑换
@property(nonatomic, strong)UIButton *splusExchangeBt;

//确定充值
@property(nonatomic, strong)UIButton *splusCommit;

@property(nonatomic, strong)NSString *aliUrl;

@property(nonatomic, strong)NSString *strPayWay;

@property(nonatomic, strong)NSString *payUrl;

@property(nonatomic, strong)NSString *payDelegateUrl;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;


@end
