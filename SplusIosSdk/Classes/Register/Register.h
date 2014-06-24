//
//  Register.h
//  SplusFramework
//
//  Created by akzhang on 14-6-19.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplusCallback.h"
//#import "DropListView.h"
#import "QCheckBox.h"
#import "GetImage.h"
#import "HttpUrl.h"
#import "AppInfo.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "GetImage.h"
#import "httpRequest.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "checkWifi.h"
#import "UserData.h"

@interface Register : UIViewController<UITextFieldDelegate>

@property(nonatomic, retain)id<SplusCallback> delegate;

@property (strong, nonatomic) IBOutlet UIView *splusLoginBgView;//设置背景图

@property (strong, nonatomic) IBOutlet UIImageView *splusLoginBgImageView;//设置背景图

@property (strong, nonatomic) IBOutlet UITextField *splusLoginUser;//用户名输入框

@property (strong, nonatomic) IBOutlet UITextField *splusLoginPwd;//密码输入框

@property (strong, nonatomic) IBOutlet UIButton *splusLoginNowBt;//登录按钮

@property (strong, nonatomic) IBOutlet QCheckBox *splusRemPwd;//记住密码复选框

//@property (strong, nonatomic) IBOutlet UILabel *splusForgetPwd;//忘记密码

@property (strong, nonatomic) IBOutlet UIButton *close;//关闭

@property (strong, nonatomic) IBOutlet UIImageView *splusSpliterLine;//分割线

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic, assign)int fastreg;

@property(nonatomic, strong)NSString *passport;//用户名

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
