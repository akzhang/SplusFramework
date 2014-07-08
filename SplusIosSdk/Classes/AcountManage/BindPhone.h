//
//  BindPhone.h
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "SplusCallback.h"
#import "MBProgressHUD.h"
#import "httpRequest.h"
#import "AppInfo.h"
#import "SplusUser.h"
#import "ActivateInfo.h"
#import "MyMD5.h"
#import "JSON.h"
#import "NSDictionary+QueryBuilder.h"

@interface BindPhone : UIViewController<UITextFieldDelegate>

@property(nonatomic, retain)id<SplusCallback> delegate;

@property (strong, nonatomic)UIImageView *splusBindBgImageView;//设置背景图

@property (strong, nonatomic)UIButton *close;//关闭

@property (strong, nonatomic)UIImageView *splusSpliterLine;//分割线

@property (strong, nonatomic)UIView *splusBindBgView;

@property(nonatomic, strong)UILabel *splusTip;

@property(nonatomic, strong)UILabel *splusBindTip;

@property(nonatomic, strong)UITextField *splusPhoneEdit;//手机号

@property(nonatomic, strong)UITextField *splusIdentEdit;//验证码

@property(nonatomic, strong)UIButton *splusGetIdent;//获取验证码

@property(nonatomic, strong)UIButton *splusCommit;//提交

@property(nonatomic, strong)NSTimer *countDownTimer;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
