//
//  HumanResources.h
//  SplusFramework
//
//  Created by akzhang on 14-7-15.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplusCallback.h"
#import "QCheckBox.h"
#import "GetImage.h"
#import "HttpUrl.h"
#import "AppInfo.h"
#import "SplusUser.h"
#import "MyMD5.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "NSDictionary+QueryBuilder.h"
#import "SplusInterfaceKit.h"
#import "ActivateInfo.h"
#import "httpRequest.h"
#import "OrderInfo.h"


@interface HumanResources : UIViewController<UITextFieldDelegate, QCheckBoxDelegate>

@property(nonatomic, strong)UIScrollView *splusScrollView;

@property(nonatomic, retain)id<SplusCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *splusWelText;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

@property(nonatomic, strong)UILabel *splusTitle;

@property(nonatomic, strong)UILabel *splusUserName;

@property(nonatomic, strong)UILabel *splusWel;

@property(nonatomic, strong)UILabel *splusSex;

@property(strong, nonatomic)QCheckBox *splusMan;//男

@property(strong, nonatomic)QCheckBox *splusWoMan;//女

@property(strong, nonatomic)QCheckBox *splusSecret;//保密

//用户名
@property(nonatomic, strong)UILabel *splusName;

//用户名输入框
@property(nonatomic, strong)UITextField *splusNameEt;

//身份证号
@property(nonatomic, strong)UILabel *splusIdentNum;

//身份证输入框
@property(nonatomic, strong)UITextField *splusIdentNumEt;

//QQ
@property(nonatomic, strong)UILabel *spluQQ;

//QQ输入框
@property(nonatomic, strong)UITextField *spluQQEt;

//资料编辑
@property(nonatomic, strong)UIButton *splusEdit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, strong)NSString *sexType;

@property(nonatomic, strong)QCheckBox *lastCheckBox;


@end
