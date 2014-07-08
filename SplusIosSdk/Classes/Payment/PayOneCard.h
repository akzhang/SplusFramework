//
//  PayOneCard.h
//  SplusFramework
//
//  Created by akzhang on 14-6-26.
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

@interface PayOneCard : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//payway
@property(nonatomic, strong)UILabel *splusPayWayText;

@property(nonatomic, strong)UILabel *splusPayValue;

//请选择充值金额
@property(nonatomic, strong)UILabel *splusCashValue;

//元宝兑换
@property(nonatomic, strong)UIButton *splusExchangeBt;

//确定充值
@property(nonatomic, strong)UIButton *splusCommit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

//splus注意
@property(nonatomic, strong)UILabel *splusTipLabel;

@property(nonatomic, strong)NSArray *cashArray;

@property(nonatomic, strong)UIImageView *splusEditFrame;

@property(nonatomic, strong)UIImageView *inputSpliterLine;

// 卡号
@property(nonatomic, strong)UITextField *splusCardNum;

// 密码
@property(nonatomic, strong)UITextField *splusCardPwd;

@property(nonatomic, strong)UIScrollView *splusScrollView;

@property(nonatomic, assign)int payway;

@property(nonatomic, strong)NSString *headTitle;

@property(nonatomic, strong)NSString *paySource;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, strong)NSString *money;

@property(nonatomic, strong)NSString *aliUrl;

@property(nonatomic, strong)NSString *strPayWay;

@property(nonatomic, strong)NSString *payUrl;

@property(nonatomic, strong)NSString *payDelegateUrl;




@end
