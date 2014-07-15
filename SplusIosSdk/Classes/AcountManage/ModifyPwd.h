//
//  ModifyPwd.h
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "httpRequest.h"
#import "MyMD5.h"
#import "NSDictionary+QueryBuilder.h"
#import "MBProgressHUD.h"
#import "SBJsonParser.h"
#import "OrderInfo.h"
#import "JSON.h"
#import "SplusUser.h"
#import "ActivateInfo.h"
#import "AppInfo.h"

@interface ModifyPwd :UIView<UITextFieldDelegate> //UIViewController<UITextFieldDelegate>

@property (strong, nonatomic)UIImageView *splusModifyBgImageView;//设置背景图

@property (strong, nonatomic)UIButton *close;//关闭

@property (strong, nonatomic)UIImageView *splusSpliterLine;//分割线

@property (strong, nonatomic)UIView *splusModifyBgView;

@property (strong, nonatomic)UITextField *splusOldPwd;//旧密码输入框

@property (strong, nonatomic)UITextField *splusNewPwd;//新密码输入框

@property (strong, nonatomic)UITextField *splusRepeatPwd;//重复密码输入框

@property(nonatomic, strong)UIButton *splusModifyBt;

@property(nonatomic, strong)MBProgressHUD *HUD;

@property(nonatomic, strong)httpRequest *aliPost;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

//@property (strong, nonatomic) IBOutlet UIImageView *splusSpliterLine;//分割线

@end
