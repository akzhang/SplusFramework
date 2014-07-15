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

NSInteger bindSeconds = 60;//60秒倒计时

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self initBindPhoneView];
//    // Do any additional setup after loading the view.
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        [self initBindPhoneView];
    }
    return self;
}

-(void)initBindPhoneView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor darkTextColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    _splusBindBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    [self addSubview:_splusBindBgView];
    
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
    [_close addTarget:self action:@selector(splusCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
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
    [_splusGetIdent addTarget:self action:@selector(splusGetIdentClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusBindBgView addSubview:_splusGetIdent];
    
    //提交
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(20, 215, 280, 45)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"提交" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusBindBgView addSubview:_splusCommit];
    
}

//倒计时
#pragma mark -Timer
-(void)timeFireMethod{
    bindSeconds--;
    NSString *tempStr = [NSString stringWithFormat:@"%d", bindSeconds];
    [_splusGetIdent setTitle:tempStr forState:UIControlStateNormal];
    if(bindSeconds==0){
        [_splusGetIdent setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countDownTimer invalidate];
        [_splusGetIdent setUserInteractionEnabled:YES];
    }
}

-(void)splusCloseClick
{
    [self removeFromSuperview];
}

//获取验证码
-(void)splusGetIdentClick:(id)sender
{
    NSString *phone = _splusPhoneEdit.text;
    if ([phone length] == 0)
    {
        [self showMessage:@"手机号不能为空"];
    }
    else if ([phone length] != 11)
    {
        [self showMessage:@"请输入正确的手机号码"];
    }
    else
    {
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:_HUD];
        _HUD.removeFromSuperViewOnHide = YES;
        [_HUD show: YES];
        
        _aliPost = [[httpRequest alloc] init];
        _aliPost.dlegate = self;
        _aliPost.success = @selector(get_callback:);
        _aliPost.error = @selector(get_error);
        
        // 登录请求
        NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
        NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
        NSString *sign = @"";
        NSString *mTime = [[AppInfo sharedSingleton] getData];
        NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
        
        sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner,[SplusUser sharedSingleton].uid, [SplusUser sharedSingleton].username, mTime ,[AppInfo sharedSingleton].gameKey];
        
        NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [SplusUser sharedSingleton].uid, @"uid",
                                    @"1",@"debug",
                                    [AppInfo sharedSingleton].gameID, @"gameid",
                                    [MyMD5 md5:sign], @"sign",
                                    mTime, @"time",
                                    [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                    partner, @"partner",
                                    [AppInfo sharedSingleton].sourceID,@"referer",
                                    [SplusUser sharedSingleton].username, @"passport",//用户名
                                    phone,nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        NSLog(@"postData modify=%@", [MODIFY_PWD stringByAppendingFormat:@"%@", postData]);
        
        [_aliPost post:GET_IDENT argData:postData];
        
        return;
    }
}

-(void)get_callback:(NSString*)tempResult
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    bindSeconds = 60;
    [_splusGetIdent setUserInteractionEnabled:NO];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    return;
}

-(void)get_error
{
    [self showMessage:@"网络连接超时"];
}

//提交
-(void)splusCommitClick:(id)sender
{
    NSString *phoneText = _splusPhoneEdit.text;
    NSString *idenText = _splusIdentEdit.text;
    if (phoneText.length == 0) {
        [self showMessage:@"手机号不能为空"];
    }else if(phoneText.length != 11){
        [self showMessage:@"手机号为11位"];
    }else if(idenText.length == 0){
        [self showMessage:@"验证码不能为空"];
    }else{
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:_HUD];
        //HUD.delegate = self;
        _HUD.removeFromSuperViewOnHide = YES;
        _HUD.dimBackground = YES;
        //HUD.labelText = @"正在注册...";
        [_HUD show: YES];
        
        httpRequest *post = [[httpRequest alloc] init];
        post.dlegate = self;
        post.success = @selector(bind_callback:);
        post.error = @selector(bind_error);
        
        // 登录请求
        NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
        NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
        NSString *sign = @"";
        NSString *mTime = [[AppInfo sharedSingleton] getData];
        NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
        
        sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner,[SplusUser sharedSingleton].uid, [SplusUser sharedSingleton].username, mTime ,[AppInfo sharedSingleton].gameKey];
        
        NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [SplusUser sharedSingleton].uid, @"uid",
                                    @"1",@"debug",
                                    [AppInfo sharedSingleton].gameID, @"gameid",
                                    [MyMD5 md5:sign], @"sign",
                                    mTime, @"time",
                                    [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                    partner, @"partner",
                                    [AppInfo sharedSingleton].sourceID,@"referer",
                                    [SplusUser sharedSingleton].username, @"passport",//用户名
                                
                                    phoneText, @"phone",
                                    idenText, @"code",
                                    nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        NSLog(@"postData modify=%@", [MODIFY_PWD stringByAppendingFormat:@"%@", postData]);
        
        [_aliPost post:BIND_PHONE argData:postData];
        
    }
}

-(BOOL)shouldAutorotate
{
    return NO;
}


//iOS 6.0旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


//iOS 6.0以下旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
}


#pragma mark -BindPhone
-(void)bind_callback:(NSString*)tempResult
{
//    [self dismissModalViewControllerAnimated:YES];
    [self removeFromSuperview];
}

-(void)bind_error
{
    [self showMessage:@"连接超时"];
}

-(void)showMessage:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

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
