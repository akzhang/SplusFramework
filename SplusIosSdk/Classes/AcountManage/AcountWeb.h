//
//  AcountWeb.h
//  SplusFramework
//
//  Created by akzhang on 14-7-8.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
#import "MBProgressHUD.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "MBProgressHUD.h"
#import "httpRequest.h"
#import "SBJsonParser.h"
#import "OrderInfo.h"
#import "JSON.h"
#import "SplusUser.h"

@interface AcountWeb : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UIWebView *webView;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

@property(nonatomic, assign)int payway;

@property(nonatomic, strong)NSString *webUrl;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, strong)NSString *payUrl;

@property(nonatomic, strong)NSString *payDelegateUrl;

@end
