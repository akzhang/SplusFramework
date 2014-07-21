//
//  HumanResources.m
//  SplusFramework
//
//  Created by akzhang on 14-7-15.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "HumanResources.h"

@interface HumanResources ()

@end

@implementation HumanResources

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
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initSafeHome];
    // Do any additional setup after loading the view.
}

-(void)initSafeHome
{
    _orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyAcountBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _splusPayText.text = @"账号安全";
    _splusPayText.font = [UIFont systemFontOfSize:20.0];
    _splusPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    
    
#pragma mark -ScrollView
    _splusScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, SCREENWIDTH, SCREENHEIGHT - 60)];
    _splusScrollView.pagingEnabled = YES;
    _splusScrollView.delegate = self;
    _splusScrollView.showsVerticalScrollIndicator = NO;
    _splusScrollView.showsHorizontalScrollIndicator = NO;
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 30);
        [_splusScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_splusScrollView setContentSize:newSize];
    }
    
    [self.view addSubview:_splusScrollView];
    
    UIView *headTitle = [[UIView alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [_splusScrollView addSubview:headTitle];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _splusTitle.text = @"尊敬的";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    _splusTitle.backgroundColor = [UIColor clearColor];
    _splusTitle.textColor = [UIColor darkGrayColor];
    [headTitle addSubview:_splusTitle];
    
    _splusUserName = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 20)];
    _splusUserName.textColor = [UIColor orangeColor];
    _splusUserName.backgroundColor = [UIColor clearColor];
    _splusUserName.text = [SplusUser sharedSingleton].username;
    [headTitle addSubview:_splusUserName];
    
    _splusWel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH - 40, 20)];
    _splusWel.textColor = [UIColor darkGrayColor];
    _splusWel.backgroundColor = [UIColor clearColor];
    _splusWel.text = @"为了保障您的账号安全，请尽快完善您的资料";
    _splusWel.font = [UIFont systemFontOfSize:12.0];
    [headTitle addSubview:_splusWel];
    
#pragma mark -NAME
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, SCREENWIDTH - 40, 35)];
    [_splusScrollView addSubview:nameView];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    _splusTitle.text = @"真实姓名:";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    _splusTitle.backgroundColor = [UIColor clearColor];
    _splusTitle.textColor = [UIColor darkGrayColor];
    [nameView addSubview:_splusTitle];
    
    _splusNameEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _splusNameEt.placeholder = @" 请输入您的姓名";
    _splusNameEt.delegate = self;
    _splusNameEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusNameEt.font = [UIFont systemFontOfSize:12.0];
    _splusNameEt.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusNameEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [nameView addSubview:_splusNameEt];
    
#pragma mark -SEX
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(20, 105, SCREENWIDTH - 40, 50)];
    [_splusScrollView addSubview:sexView];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 60, 20)];
    _splusTitle.text = @"性     别  :";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    _splusTitle.backgroundColor = [UIColor clearColor];
    _splusTitle.textColor = [UIColor darkGrayColor];
    [sexView addSubview:_splusTitle];
    
    _splusMan = [[QCheckBox alloc] initWithDelegate:self];
    _splusMan.frame = CGRectMake(60, 0, 80, 50);
    _splusMan.tag = 1;
    [_splusMan setChecked:YES];
    [_splusMan setTitle:@"男" forState:UIControlStateNormal];
    [_splusMan setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_splusMan.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_splusMan];
    
    _splusWoMan = [[QCheckBox alloc] initWithDelegate:self];
    _splusWoMan.frame = CGRectMake(140, 0, 80, 50);
    _splusWoMan.tag = 2;
    [_splusWoMan setChecked:YES];
    [_splusWoMan setTitle:@"女" forState:UIControlStateNormal];
    [_splusWoMan setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_splusWoMan.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_splusWoMan];
    
    
    _splusSecret = [[QCheckBox alloc] initWithDelegate:self];
    _splusSecret.frame = CGRectMake(220, 0, 80, 50);
    _splusSecret.tag = 3;
    [_splusSecret setChecked:YES];
    [_splusSecret setTitle:@"保密" forState:UIControlStateNormal];
    [_splusSecret setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_splusSecret.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [sexView addSubview:_splusSecret];
    
    
#pragma mark -IdentNum
    UIView *identView = [[UIView alloc] initWithFrame:CGRectMake(20, 165, SCREENWIDTH - 40, 35)];
    [_splusScrollView addSubview:identView];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _splusTitle.text = @"身 份 证  :";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    _splusTitle.backgroundColor = [UIColor clearColor];
    _splusTitle.textColor = [UIColor darkGrayColor];
    [identView addSubview:_splusTitle];
    
    _splusNameEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _splusNameEt.placeholder = @" 请输入您的身份证号码";
    _splusNameEt.delegate = self;
    _splusNameEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusNameEt.font = [UIFont systemFontOfSize:12.0];
    _splusNameEt.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusNameEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [identView addSubview:_splusNameEt];
    
#pragma mark -QQ
    UIView *qqView = [[UIView alloc] initWithFrame:CGRectMake(20, 210, SCREENWIDTH - 40, 35)];
    [_splusScrollView addSubview:qqView];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 20)];
    _splusTitle.text = @"您 的 QQ:";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    _splusTitle.backgroundColor = [UIColor clearColor];
    _splusTitle.textColor = [UIColor darkGrayColor];
    [qqView addSubview:_splusTitle];
    
    _splusNameEt = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 100, 35)];
    _splusNameEt.placeholder = @" 请输入您的QQ号";
    _splusNameEt.delegate = self;
    _splusNameEt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusNameEt.font = [UIFont systemFontOfSize:12.0];
    _splusNameEt.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusNameEt.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [qqView addSubview:_splusNameEt];
    
    
    _splusEdit = [[UIButton alloc] initWithFrame:CGRectMake(20, 255, SCREENWIDTH - 40, 50)];
    [_splusEdit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusEdit setTitle:@"提    交" forState:UIControlStateNormal];
    _splusEdit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusEdit addTarget:self action:@selector(splusCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusScrollView addSubview:_splusEdit];
    
    
}

#pragma mark -VillApper
-(void)viewWillAppear:(BOOL)animated
{
    //获取用户信息
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走，正在获取信息中...";
    [_HUD show: YES];
    
    // 请求参数
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
    NSString *gameID = [AppInfo sharedSingleton].gameID;
    NSString *sourceID = [AppInfo sharedSingleton].sourceID;
    NSString *uid = [SplusUser sharedSingleton].uid;
    NSString *password = [SplusUser sharedSingleton].passwd;
    NSString *userName = [SplusUser sharedSingleton].username;
    NSString *appKey = [AppInfo sharedSingleton].gameKey;
    NSString *action = @"checkuserinfo";
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", gameID, deviceNo, sourceID, partner, uid, userName, mTime, appKey];
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"gameid",
                                deviceNo, @"deviceno",
                                sourceID,@"referer",
                                partner, @"partner",
                                uid, @"uid",
                                userName, @"passport",//用户名
                                action, @"action",
                                mTime, @"time",
                                [MyMD5 md5:sign], @"sign",
                                @"1",@"debug", nil];
    NSString *postData = [dictionary buildQueryString];
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(get_user_callback:);
    _request.error = @selector(get_user_error);
    [_request post:GET_USER_INFO argData:postData];
}

-(void)yyAcountBackClick
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)yyCustomClick
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)get_user_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }

    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *code = [rootDic objectForKey:@"code"];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *realname = [data objectForKey:@"realname"];
    NSString *idcard = [data objectForKey:@"idcard"];
    NSString *qq = [data objectForKey:@"qq"];
    
    _splusNameEt.text = realname;
    _spluQQEt.text = qq;
    _splusIdentNumEt.text = idcard;
}

-(void)get_user_error
{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(void)splusCommitClick:(id)sender
{
    //提交用户信息
    // 请求参数
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    NSString *deviceNo = [ActivateInfo sharedSingleton].deviceno;
    NSString *gameID = [AppInfo sharedSingleton].gameID;
    NSString *sourceID = [AppInfo sharedSingleton].sourceID;
    NSString *uid = [SplusUser sharedSingleton].uid;
    NSString *password = [SplusUser sharedSingleton].passwd;
    NSString *userName = [SplusUser sharedSingleton].username;
    NSString *appKey = [AppInfo sharedSingleton].gameKey;
    NSString *action = @"checkuserinfo";
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@", gameID, deviceNo, sourceID, partner, uid, userName, mTime, appKey];
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:gameID, @"gameid",
                                deviceNo, @"deviceno",
                                sourceID,@"referer",
                                partner, @"partner",
                                uid, @"uid",
                                userName, @"passport",//用户名
                                action, @"action",
                                mTime, @"time",
                                [MyMD5 md5:sign], @"sign",
                                [OrderInfo sharedSingleton].serverName, @"serverName",
                                _splusNameEt.text, @"realname",
                                _sexType, @"gendertype",
                                _splusIdentNum.text, @"idcard",
                                _spluQQEt.text, @"qq",
                                @"1",@"debug", nil];
    NSString *postData = [dictionary buildQueryString];
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(modify_user_callback:);
    _request.error = @selector(modify_user_error);
    [_request post:MODIFY_USER_INOF argData:postData];
}

//修改成功callback
-(void)modify_user_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSDictionary *rootDic = [parser objectWithString:result];
//    NSString *code = [rootDic objectForKey:@"code"];
//    NSDictionary *data = [rootDic objectForKey:@"data"];
//    NSString *realname = [data objectForKey:@"realname"];
//    NSString *idcard = [data objectForKey:@"idcard"];
//    NSString *qq = [data objectForKey:@"qq"];
}

-(void)modify_user_error
{
    if (_HUD != NULL)
    {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    
    if (_lastCheckBox) {//是否最后一次选中
        [_lastCheckBox setChecked:YES];
    }
    
    QCheckBox *chooseBox = checkbox;
//    [chooseBox setChecked:NO];
    _lastCheckBox = chooseBox;
    
    NSLog(@"%@",checked?@"YES":@"NO");
    
    switch (chooseBox.tag) {
        case 1://男
            _sexType = @"1";
            break;
            
        case 2://保密
            _sexType = @"2";
            break;
            
        default://女
            _sexType = @"0";
            break;
    }
}

-(void)yyPayBackClick:(id)sender{
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotate
{
    return NO;
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



//iOS 6.0旋屏支持方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

//iOS 6.0以下旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
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
