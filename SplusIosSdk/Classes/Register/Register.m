//
//  Register.m
//  SplusFramework
//
//  Created by akzhang on 14-6-19.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "Register.h"

@interface Register ()

@end

@implementation Register

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
    [self initRegisterView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initRegisterView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    _splusLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    [self.view addSubview:_splusLoginBgView];
    
    _splusLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusLoginBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusLoginBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusLoginBgView addSubview:_splusLoginBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 50, 25, 100, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:20.0];
    splusTitle.text = @"账号注册";
    [_splusLoginBgView addSubview:splusTitle];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 45, 45)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(splusTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusLoginBgView addSubview:_back];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(splusRegisterClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusLoginBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusLoginBgView addSubview:_splusSpliterLine];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 280, 100)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [_splusLoginBgView addSubview:splusEditFrame];
    
    //用户名
    _splusLoginUser = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, 280, 50)];
    UIView *userleftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
    UIImageView *userLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"splus_login_user"]];
    userLogoImage.contentMode = UIViewContentModeScaleToFill;
    userLogoImage.frame = CGRectMake(7, 12, 25, 25);
    [userleftview addSubview:userLogoImage];
    _splusLoginUser.leftView = userleftview;
    _splusLoginUser.leftViewMode = UITextFieldViewModeAlways;
    _splusLoginUser.placeholder = @" 账号:手机号/数字字母组合";
    _splusLoginUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusLoginUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _splusLoginUser.delegate = self;
    _splusLoginUser.font = [UIFont systemFontOfSize:12.0];
    [_splusLoginBgView addSubview:_splusLoginUser];
    
    UIImageView* inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 278, 1)];
    [inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusLoginBgView addSubview:inputSpliterLine];
    
    //密码
    _splusLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 50)];
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 50)];
    UIImageView *passwdLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"splus_input_pwd"]];
    passwdLogoImage.frame = CGRectMake(7, 12, 25, 25);
    [leftview addSubview:passwdLogoImage];
    _splusLoginPwd.leftView = leftview;
    _splusLoginPwd.leftViewMode = UITextFieldViewModeAlways;
    _splusLoginPwd.placeholder = @" 密码:6-20位字母、数字、下划线";
    _splusLoginPwd.delegate = self;
    [_splusLoginPwd setSecureTextEntry:TRUE];
    _splusLoginPwd.font = [UIFont systemFontOfSize:12.0];
    _splusLoginPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusLoginPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_splusLoginBgView addSubview:_splusLoginPwd];
    
    _splusRemPwd = [[QCheckBox alloc] initWithDelegate:self];
    _splusRemPwd.frame = CGRectMake(25, 180, 180, 50);
    [_splusRemPwd setTitle:@"同意《灿和用户服务条款》" forState:UIControlStateNormal];
    [_splusRemPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_splusRemPwd.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_splusLoginBgView addSubview:_splusRemPwd];
    
    //立即登录
    _splusLoginNowBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 280, 35)];
    [_splusLoginNowBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusLoginNowBt setTitle:@"立即登录" forState:UIControlStateNormal];
    _splusLoginNowBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusLoginNowBt addTarget:self action:@selector(splusLoginNowClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusLoginBgView addSubview:_splusLoginNowBt];
    
    if ([[ActivateInfo sharedSingleton].relationships intValue] == 0)//未激活
    {
        _fastreg = 1;
        _passport = [ActivateInfo sharedSingleton].passport;
        _splusLoginUser.text = _passport;
    }
    else
    {
        _fastreg = 0;
    }
    
}

-(void)splusTipClick:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
}

-(void)splusRegisterClick
{
    [self dismissModalViewControllerAnimated:NO];
}

-(void)splusLoginNowClick
{
    if (_splusLoginUser.text.length < 5|| _splusLoginUser.text.length > 20) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名输入错误(5-20个字符)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (_splusLoginPwd.text.length < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误(5-20个字符)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![checkWifi connectedToNetWork]){//|| ![checkWifi IsEnable3G] || ![checkWifi IsEnableWIFI]
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接错误，请检查网络是否正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (_splusRemPwd.checked == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请同意灿和用户协议" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，正在加载中...";
    [_HUD show: YES];
    
    NSLog(@"passport = %d", [[ActivateInfo sharedSingleton].relationships intValue]);

    if (_splusLoginUser.text != [ActivateInfo sharedSingleton].passport) {
        _fastreg = 0;
    }
    
    _passport = _splusLoginUser.text;
    
    // 登录请求
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    
    NSString *sign = @"";
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner, _passport,_splusLoginPwd.text,[[AppInfo sharedSingleton] getData], [AppInfo sharedSingleton].gameKey];
    NSLog(@"sign = %@", sign);
    NSLog(@"Md5 = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                [AppInfo sharedSingleton].sourceID,@"referer",
                                partner, @"partner",
                                _passport, @"passport",//用户名
                                _splusLoginPwd.text, @"password",//密码
                                [NSString stringWithFormat:@"%d", _fastreg], @"fastreg",
                                [[AppInfo sharedSingleton] getData], @"time",
                                @"1",@"debug",
                                [MyMD5 md5:sign], @"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    NSLog(@"postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(register_callback:);
    _request.error = @selector(register_error);
    [_request post:API_URL_REGISTER argData:postData];
}

-(void)register_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)register_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    //注册成功，录入信息
    [UserData push:_splusLoginUser.text password:_splusLoginPwd.text];
    
    NSLog(@"login info result = %@", result);//登录信息
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *code = [rootDic objectForKey:@"code"];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *uid = [data objectForKey:@"uid"];
    NSString *sessionid = [data objectForKey:@"sessionid"];
    [[SplusUser sharedSingleton] initWithType:_passport Pwd:_splusLoginPwd.text Sessiond:sessionid Uid:uid];
    
    if ([code intValue] == 1)
    {
        //激活成功，callback
        [self dismissModalViewControllerAnimated:NO];
        [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[rootDic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 200 - (self.view.frame.size.height -216.0);
        }
        
    }else{//机型是ipad
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            offset = frame.origin.y + 100 - (self.view.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 190 - (self.view.frame.size.height -216.0);
        }
        
    }
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            self.view.frame =CGRectMake(0.0f, -offset,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
        }else{
            self.view.frame =CGRectMake(0, 0.0f,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
        }
    
    [UIView commitAnimations];
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    tipValue = REGISTER_SERVER;
    QutoPayTip *tip = [[QutoPayTip alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:tip];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
