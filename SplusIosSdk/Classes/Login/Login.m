//
//  Login.m
//  SplusIosSdk
//
//  Created by akzhang on 14-6-17.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

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
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    self.view.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];
    [self initLoginView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initLoginView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    _splusLoginBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    [self.view addSubview:_splusLoginBgView];
    
    _splusLoginBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusLoginBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusLoginBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusLoginBgView addSubview:_splusLoginBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 80, 25, 160, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:22.0];
    splusTitle.text = @"SPlus账号登录";
    [_splusLoginBgView addSubview:splusTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_splusLoginBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusLoginBgView addSubview:_splusSpliterLine];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 280, 100)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [_splusLoginBgView addSubview:splusEditFrame];
    
    //用户名
    _splusLoginUser = [[DropListView alloc] initWithFrame:CGRectMake(20, 70, 280, 50)];
    _splusLoginUser.positionDelegate = self;
    _splusLoginUser.textField.delegate = self;
    //_yyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_splusLoginBgView addSubview:_splusLoginUser];
    
    UIImageView* inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 278, 1)];
    [inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusLoginBgView addSubview:inputSpliterLine];
    
    //密码
    _splusLoginPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 50)];
    UIImageView *passwdLogoImage=[[UIImageView alloc] initWithImage:[GetImage imagesNamedFromCustomBundle:@"splus_input_pwd"]];
    
    passwdLogoImage.frame = CGRectMake(50, 0, 25, 25);
    _splusLoginPwd.leftView = passwdLogoImage;
    _splusLoginPwd.leftViewMode = UITextFieldViewModeAlways;
    _splusLoginPwd.placeholder = @" 请输入密码";
    _splusLoginPwd.delegate = self;
    [_splusLoginPwd setSecureTextEntry:TRUE];
    _splusLoginPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusLoginPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_splusLoginBgView addSubview:_splusLoginPwd];
    
    _splusRemPwd = [[QCheckBox alloc] initWithDelegate:self];
    _splusRemPwd.frame = CGRectMake(25, 180, 80, 50);
    [_splusRemPwd setTitle:@"记住密码" forState:UIControlStateNormal];
    [_splusRemPwd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_splusRemPwd.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_splusLoginBgView addSubview:_splusRemPwd];
    
    _splusForgetPwd = [[UILabel alloc] initWithFrame:CGRectMake(240, 180, 80, 40)];
    _splusForgetPwd.text = @"忘记密码?";
    _splusForgetPwd.font = [UIFont systemFontOfSize:12.0];
    _splusForgetPwd.textColor = [UIColor blueColor];
    [_splusLoginBgView addSubview:_splusForgetPwd];
    
    //一键注册
    _splusRegisterBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 135, 35)];
    [_splusRegisterBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_register_bt"] forState:UIControlStateNormal];
    [_splusRegisterBt setTitle:@"注册" forState:UIControlStateNormal];
    _splusRegisterBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusRegisterBt addTarget:self action:@selector(splusRegisterClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusLoginBgView addSubview:_splusRegisterBt];
    
    //立即登陆
    _splusLoginBt = [[UIButton alloc] initWithFrame:CGRectMake(165, 230, 135, 35)];
    [_splusLoginBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusLoginBt setTitle:@"进入游戏" forState:UIControlStateNormal];
    _splusLoginBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusLoginBt addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusLoginBgView addSubview:_splusLoginBt];
}

-(void)splusRegisterClick:(id)sender
{
    Register *splusRegister = [[Register alloc] init];
    [self presentModalViewController:splusRegister animated:NO];
}

//注册成功callback
-(void)back
{
    [_delegate SplusLoginOnSuccess:[SplusUser sharedSingleton]];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)splusLoginClick:(id)sender
{
    if (_splusLoginUser.textField.text.length < 5|| _splusLoginUser.textField.text.length > 20) {
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
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，正在加载中...";
    [_HUD show: YES];
    
    _passport = _splusLoginUser.textField.text;
    
    // 登录请求
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner, _passport, _splusLoginPwd.text, mTime, [AppInfo sharedSingleton].gameKey];
    
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                [AppInfo sharedSingleton].sourceID,@"referer",
                                partner, @"partner",
                                _passport, @"passport",//用户名
                                _splusLoginPwd.text, @"password",//密码
                                mTime, @"time",
                                @"1",@"debug",
                                [MyMD5 md5:sign], @"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    NSLog(@"postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(logion_callback:);
    _request.error = @selector(login_error);
    [_request post:API_URL_LOGIN argData:postData];
}

-(void)logion_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }

    [UserData push:_splusLoginUser.textField.text password:_splusLoginPwd.text];
    
    NSLog(@"login info result = %@", result);//登录信息
    
    NSError *error = nil;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result error:&error];
    NSString *code = [rootDic objectForKey:@"code"];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *uid = [data objectForKey:@"uid"];
    NSString *sessionid = [data objectForKey:@"sessionid"];
    [[SplusUser sharedSingleton] initWithType:_passport Pwd:_splusLoginPwd.text Sessiond:sessionid Uid:uid];
    
    if ([code intValue] == 1)
    {
        //登录成功，callback
        [self back];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[rootDic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)login_error{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -VillApper
-(void)viewWillAppear:(BOOL)animated{
    _UserArray = [[NSMutableArray alloc] init];
    _PasswordArray = [[NSMutableArray alloc] init];
    
    NSDictionary *queryResult = [UserData get];
    NSEnumerator *enumeratorKey = [queryResult keyEnumerator];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    
    //遍历所有key
    for (NSString *object in enumeratorKey){
        NSDictionary *userInfo = [[UserData get] objectForKey:object];
        //字典
        [result addObject:userInfo];
    }
    
    NSArray *newResult =
    [result sortedArrayUsingComparator:^(id obj1,id obj2)
     {
         NSDictionary *dic1 = (NSDictionary *)obj1;
         NSDictionary *dic2 = (NSDictionary *)obj2;
         NSNumber *num1 = (NSNumber *)[dic1 objectForKey:@"last_date"];
         NSNumber *num2 = (NSNumber *)[dic2 objectForKey:@"last_date"];
         if ([num1 floatValue] > [num2 floatValue])
         {
             return (NSComparisonResult)NSOrderedAscending;
         }
         else
         {
             return (NSComparisonResult)NSOrderedDescending;
         }
         return (NSComparisonResult)NSOrderedSame;
     }];
    
    for (id user in newResult){
        //字典
        [_UserArray addObject:[user objectForKey:@"username"]];
        [_PasswordArray addObject:[user objectForKey:@"password"]];
    }
    
    if ([_UserArray count] != 0) {
        _splusLoginUser.textField.text = [_UserArray objectAtIndex:0];
        _splusLoginPwd.text = [_PasswordArray objectAtIndex:0];
        _splusLoginUser.tableArray = _UserArray;
    }
    
}

/**
 *  设置选择相应的position
 *
 *  @param position 选择的position位置
 */
-(void)setPasswdText:(NSInteger)position{
    
    if ([_UserArray count] != 0) {
        NSLog(@"passwd = %@",[_PasswordArray objectAtIndex:position]);
        _splusLoginPwd.text = [_PasswordArray objectAtIndex:position];
    }
}

-(void)setCleanIndex:(NSInteger)position{
    
    if (0 != [_UserArray count]) {
        //移除
        [UserData pop:[_UserArray objectAtIndex:position]];
        
        NSDictionary *queryResult = [UserData get];
        NSEnumerator *enumeratorKey = [queryResult keyEnumerator];
        
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
        
        //遍历所有key
        for (NSString *object in enumeratorKey){
            NSDictionary *userInfo = [[UserData get] objectForKey:object];
            //字典
            [result addObject:userInfo];
        }
        
        NSArray *newResult =
        [result sortedArrayUsingComparator:^(id obj1,id obj2)
         {
             NSDictionary *dic1 = (NSDictionary *)obj1;
             NSDictionary *dic2 = (NSDictionary *)obj2;
             NSNumber *num1 = (NSNumber *)[dic1 objectForKey:@"last_date"];
             NSNumber *num2 = (NSNumber *)[dic2 objectForKey:@"last_date"];
             if ([num1 floatValue] > [num2 floatValue])
             {
                 return (NSComparisonResult)NSOrderedAscending;
             }
             else
             {
                 return (NSComparisonResult)NSOrderedDescending;
             }
             return (NSComparisonResult)NSOrderedSame;
         }];
        
        NSMutableArray *newUserArray = [[NSMutableArray alloc] init];
        NSMutableArray *newPasswdArray = [[NSMutableArray alloc] init];
        
        for (id user in newResult){
            //字典
            [newUserArray addObject:[user objectForKey:@"username"]];
            [newPasswdArray addObject:[user objectForKey:@"password"]];
        }
        
        _UserArray = newUserArray;
        _PasswordArray = newPasswdArray;
        _splusLoginUser.tableArray = _UserArray;
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
            offset = frame.origin.y + 180 - (self.view.frame.size.height -216.0);
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
            self.view.frame =CGRectMake(offset, 0.0f,self.view.frame.size.width,self.view.frame.size.height);//-offset 0.0f
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
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
