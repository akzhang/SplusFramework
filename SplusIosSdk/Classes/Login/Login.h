//
//  Login.h
//  SplusIosSdk
//
//  Created by akzhang on 14-6-17.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "SplusCallback.h"
#import "HttpUrl.h"
#import "DropListView.h"
#import "GetImage.h"
#import "Register.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "GetImage.h"
#import "httpRequest.h"
#import "MBProgressHUD.h"
#import "UserData.h"
#import "JSON.h"
#import "RCDraggableButton.h"
#import "HomeButton.h"
#import "SplusInterfaceKit.h"
#import "AcountWeb.h"

@interface Login : UIViewController<QCheckBoxDelegate,UITextFieldDelegate,qqLoginPositionDelegate>

@property(nonatomic, retain)id<SplusCallback> delegate;

@property (strong, nonatomic) IBOutlet UIView *splusLoginBgView;//设置背景图

@property (strong, nonatomic) IBOutlet UIImageView *splusLoginBgImageView;//设置背景图

@property (strong, nonatomic) IBOutlet DropListView *splusLoginUser;//用户名输入框

@property (strong, nonatomic) IBOutlet UITextField *splusLoginPwd;//密码输入框

@property (strong, nonatomic) IBOutlet UIButton *splusRegisterBt;//注册按钮

@property (strong, nonatomic) IBOutlet UIButton *splusLoginBt;//登录按钮

@property (strong, nonatomic) IBOutlet QCheckBox *splusRemPwd;//记住密码复选框

@property (strong, nonatomic) IBOutlet UILabel *splusForgetPwd;//忘记密码

@property (strong, nonatomic) IBOutlet UIButton *close;//关闭

@property (strong, nonatomic) IBOutlet UIImageView *splusSpliterLine;//分割线

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)NSString *passport;//用户名

@property(nonatomic, retain)NSMutableArray *UserArray;

@property(nonatomic, retain)NSMutableArray *PasswordArray;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, strong)UIView *tabBarView;

@property(nonatomic, strong)UIView *fullbgView;

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)UIWindow* floatWindow;


@end
