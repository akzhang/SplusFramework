//
//  BindPhone.m
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "BindPhone.h"

@interface BindPhone ()

@end

@implementation BindPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBindPhoneView];
    // Do any additional setup after loading the view.
}

-(void)initBindPhoneView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    _splusBindBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    [self.view addSubview:_splusBindBgView];
    
    _splusBindBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusBindBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusBindBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusBindBgView addSubview:_splusBindBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 50, 25, 100, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:15.0];
    splusTitle.text = @"绑定手机";
    [_splusBindBgView addSubview:splusTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(splusRegisterClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusBindBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusBindBgView addSubview:_splusSpliterLine];
    
    _splusTip = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 100, 20)];
    _splusTip.textColor = UIColorFromRGB(0xdd0000);
    _splusTip.font = [UIFont systemFontOfSize:12.0];
    _splusTip.text = @"您的账号很危险";
    [_splusBindBgView addSubview:_splusTip];
    
    _splusBindTip = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 250, 20)];
    _splusBindTip.textColor = UIColorFromRGB(0x999999);
    _splusBindTip.font = [UIFont systemFontOfSize:11.0];
    _splusBindTip.text = @"请尽快绑定手机，忘记密码后可及时通过手机找回";
    [_splusBindBgView addSubview:_splusBindTip];
    
    //手机号
    _splusPhoneEdit = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 280, 45)];
//    UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage getSmallRectImage:@"splus_login_user"]];
//    userLogoImage.frame = CGRectMake(50, 0, 25, 25);
//    _splusPhoneEdit.leftView = userLogoImage;
//    _splusPhoneEdit.leftViewMode = UITextFieldViewModeAlways;
    _splusPhoneEdit.placeholder = @" 请输入您的手机号";
    _splusPhoneEdit.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusPhoneEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusPhoneEdit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _splusPhoneEdit.delegate = self;
    _splusPhoneEdit.font = [UIFont systemFontOfSize:12.0];
    [_splusBindBgView addSubview:_splusPhoneEdit];
    
    //验证码
    _splusIdentEdit = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, 200, 45)];
//    UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage getSmallRectImage:@"splus_login_user"]];
//    userLogoImage.frame = CGRectMake(50, 0, 25, 25);
//    _splusIdentEdit.leftView = userLogoImage;
//    _splusIdentEdit.leftViewMode = UITextFieldViewModeAlways;
    _splusIdentEdit.placeholder = @" 请输入您收到的验证码";
    _splusIdentEdit.font = [UIFont systemFontOfSize:12.0];
    _splusIdentEdit.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusIdentEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusIdentEdit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _splusIdentEdit.delegate = self;
    [_splusBindBgView addSubview:_splusIdentEdit];
    
    //获取验证码
    _splusGetIdent = [[UIButton alloc] initWithFrame:CGRectMake(230, 160, 70, 45)];
    [_splusGetIdent setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusGetIdent setTitle:@"获取验证码" forState:UIControlStateNormal];
    _splusGetIdent.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusGetIdent addTarget:self action:@selector(splusLoginNowClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusBindBgView addSubview:_splusGetIdent];
    
    //提交
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(20, 215, 280, 45)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"提交" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusLoginNowClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusBindBgView addSubview:_splusCommit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
