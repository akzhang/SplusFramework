//
//  PayValue.m
//  SplusFramework
//
//  Created by akzhang on 14-6-25.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "PayCreditCard.h"



@interface PayCreditCard ()

@end

@implementation PayCreditCard


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
    
    _cashArray = [NSArray arrayWithObjects:@"10元", @"20元", @"30元", @"50元", @"100元", @"150元", @"200元", @"300元", @"500元", nil];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initPayValue];
    
    if (_orientation != UIDeviceOrientationPortrait)
    {
        [self initPayValueLand];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPayValue
{
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    
    switch (_payway)
    {
        case 0:
            _splusPayText.text = @"支付宝快捷";
            _paySource = ALIPAY_FAST_PAYWAY;
            break;
        case 1:
            _splusPayText.text = @"支付宝web";
            _paySource = ALIPAY_WAP_PAYWAY;
            break;
        
        case 2:
            _splusPayText.text = @"储蓄卡";
            _paySource = ALIPAY_CREDIT_PAYWAY;
            break;
            
        default:
            _splusPayText.text = @"信用卡";
            _paySource = ALIPAY_DEPOSIT_PAYWAY;
            break;
    }
    
    _splusPayText.font = [UIFont systemFontOfSize:14.0];
    _splusPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    
    _splusPayWayText = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 140, 50)];
    _splusPayWayText.text = @"您选择的充值方式为:";
    _splusPayWayText.font = [UIFont systemFontOfSize:14.0];
    _splusPayWayText.textColor = UIColorFromRGB(0x999999);
    [self.view addSubview:_splusPayWayText];
    
    _splusPayValue = [[UILabel alloc] initWithFrame:CGRectMake(145, 60, 80, 50)];
//    _splusPayValue.text = @"支付宝";
    _splusPayValue.text = _splusPayText.text;
    _splusPayValue.font = [UIFont systemFontOfSize:15.0];
    _splusPayValue.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_splusPayValue];
    
    
    _splusCashValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 200, 50)];
    _splusCashValue.text = @"请选择充值金额:";
    _splusCashValue.font = [UIFont systemFontOfSize:14.0];
    _splusCashValue.textColor = UIColorFromRGB(0x666666);
    [self.view addSubview:_splusCashValue];
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        [self initWithLandButton];
    }
    else
    {
        [self initWithButton];
    }
    
    _splusTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 325, SCREENWIDTH - 30, 40)];
    _splusTipLabel.textColor = UIColorFromRGB(0xff6600);
    _splusTipLabel.text = @"注:请选择与充值金额等值的充值卡";
    _splusTipLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_splusTipLabel];
    
    _splusCashTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 375, SCREENWIDTH - 30, 40)];
    _splusCashTextField.placeholder = @" 自定义金额(元)";
    _splusCashTextField.delegate = self;
    _splusCashTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusCashTextField.background = [GetImage getSmallRectImage:@"splus_cash_input"];
    _splusCashTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_splusCashTextField];
    
    //交换
    _splusExchangeBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 425, SCREENWIDTH - 30, 35)];
    [_splusExchangeBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_value_bg"] forState:UIControlStateNormal];
    [_splusExchangeBt setTitle:@"50元可兑换350个元宝" forState:UIControlStateNormal];
    _splusExchangeBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusExchangeBt addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    _splusExchangeBt.userInteractionEnabled = NO;
    [self.view addSubview:_splusExchangeBt];
    
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, 470, SCREENWIDTH - 30, 35)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"确定充值" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_splusCommit];
}

//横屏
#pragma mark -Land
-(void)initPayValueLand
{
    [_back setFrame:CGRectMake(5, 2, 50, 30)];
    
    [_splusPayText setFrame:CGRectMake(SCREENWIDTH/2 - 40, 2, 80, 30)];
    
    [_custom setFrame:CGRectMake(SCREENWIDTH - 55, 2, 50, 30)];
    
    [_splusSplitLine setFrame:CGRectMake(0, 32, SCREENWIDTH, 1)];

    [_splusPayWayText setFrame:CGRectMake(15, 40, 140, 20)];

    [_splusPayValue setFrame:CGRectMake(155, 40, 140, 20)];
    
    [_splusCashValue setFrame:CGRectMake(15, 60, 200, 20)];
    
    [_splusTipLabel setFrame:CGRectMake(15, 175, SCREENWIDTH - 30, 20)];
    
    [_splusCashTextField setFrame:CGRectMake(15, 200, SCREENWIDTH - 30, 35)];
    
    //交换
    [_splusExchangeBt setFrame:CGRectMake(15, 240, SCREENWIDTH - 30, 35)];
    
    [_splusCommit setFrame:CGRectMake(15, 280, SCREENWIDTH - 30, 35)];
}

#pragma mark -PoritButton
-(void)initWithButton
{
    int count = 1;
    
    for (int i = 1; i< 4; i++)
    {
        for (int j = 1; j < 4; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title = [self.cashArray objectAtIndex:count - 1];
            [button setTag:count];
            count++;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            [button setBackgroundImage:[GetImage getSmallRectImage:@"splus_cash_bg"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 1)//1
            {
                button.frame = CGRectMake(100*j - 85, 160, 90, 45);
            }
            else if(i == 2)//2
            {
                button.frame = CGRectMake(100*j - 85, 215, 90, 45);
            }
            else//3
            {
                button.frame = CGRectMake(100*j - 85, 270, 90, 45);
            }
            
            [self.view addSubview:button];
        }
    }

}

#pragma mark -LandButton
-(void)initWithLandButton
{
    int count = 1;
    
    for (int i = 1; i < 3; i++)
    {
        for (int j = 1; j < 6; j++) {
            if (count > 8) {
                break;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title = [self.cashArray objectAtIndex:count - 1];
            [button setTag:count];
            count++;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            [button setBackgroundImage:[GetImage getSmallRectImage:@"splus_cash_bg"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectCashButton:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 1)//1行
            {
                button.frame = CGRectMake(90*j - 75, 90, 80, 35);
            }
            else//2行
            {
                button.frame = CGRectMake(90*j - 75, 135, 80, 35);
            }
            
            [self.view addSubview:button];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走， 正在获取信息中...";
    [_HUD show: YES];
    
    // 汇率信息
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    
    NSString *sign = @"";
    sign = [sign stringByAppendingFormat:@"%@%@%@%@", [AppInfo sharedSingleton].gameID, _paySource, [[AppInfo sharedSingleton] getData], [AppInfo sharedSingleton].gameKey];
    NSLog(@"sign = %@", sign);
    NSLog(@"Md5 = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                _paySource, @"payway",
                                [[AppInfo sharedSingleton] getData], @"time",
                                @"1",@"debug",
                                [MyMD5 md5:sign], @"sign",nil];
    
    NSString *postData = [dictionary buildQueryString];
    NSLog(@"postData = %@", postData);
    
    httpRequest *_request = [[httpRequest alloc] init];
    _request.dlegate = self;
    _request.success = @selector(coin_callback:);
    _request.error = @selector(coin_error);
    [_request post:API_URL_COIN argData:postData];
}

-(void)coin_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    NSLog(@"ratio =%@",result);

    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSDictionary *data = [rootDic objectForKey:@"data"];
    NSString *coin_name = [data objectForKey:@"coin_name"];
    NSString *ratio = [data objectForKey:@"ratio"];
    [[CoinRatio sharedSingleton] initWithType:coin_name Ratio:[ratio intValue]];
}

-(void)coin_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

//back
-(void)yyPayBackClick
{
    [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
}

-(void)selectCashButton:(id)sender
{
    if (_FlastSelectbutton) {//是否最后一次选中
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"splus_cash_bg"] forState:UIControlStateNormal];
    }
    UIButton *AButton=sender;
    [AButton setBackgroundImage:[GetImage getPayRectImage:@"splus_pay_choose"] forState:UIControlStateNormal];
    [AButton setContentMode:UIViewContentModeScaleAspectFill];
    _FlastSelectbutton=AButton;
    
    //兑换率
    int mRatio = [CoinRatio sharedSingleton].ratio;
    NSLog(@"mRatio = %d", mRatio);
    NSString *btValue = [_cashArray objectAtIndex:_FlastSelectbutton.tag - 1];
    NSString *cashValue = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@元可以兑换%d元宝", btValue, [btValue intValue]*mRatio]];
    [_splusExchangeBt setTitle:cashValue forState:UIControlStateNormal];
    
}

//提交按钮
-(void)splusCommitClick:(id)sender
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"官人别走， 正在获取信息中...";
    [_HUD show: YES];
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    
    switch (_payway) {
        case 0:
        {
            _strPayWay = ALIPAY_FAST_PAYWAY;
            _payUrl = PAY_URL;
            UIApplication *app = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:@"alipay://alipay"];
            if ([app canOpenURL:url] &&  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                _aliPost.success = @selector(alipayKuai_callback:);
            }
        }
            break;
        
        case 1:
        {
            _strPayWay = ALIPAY_WAP_PAYWAY;
            _payUrl = HTMLWAPPAY_URL;
        }
            break;
            
        case 2:
        {
            _strPayWay = UNION_PAYWAY;
            _payUrl = PAY_URL;
            _aliPost.success = @selector(unin_callback:);//payPostStr
            
        }
            break;
            
        default:
            _strPayWay = ALIPAY_CREDIT_PAYWAY;
            _payUrl = HTMLWAPPAY_URL;
            break;
    }
    
        // 登录请求
        NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
        NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
        NSString *sign = @"";
        NSString *mTime = [[AppInfo sharedSingleton] getData];
        NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
        NSString *mSelfCash = _splusCashTextField.text;
        NSLog(@"==mSelfCash= %@", mSelfCash);
        
        if ([mSelfCash length] == 0)
        {
            _money = _FlastSelectbutton.titleLabel.text;
        }
        else
        {
            _money = mSelfCash;
        }
        
        if ([_money length] == 0) {
            [self showAlertMessage:@"请选择您要充值的金额"];
        }
        
        sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [OrderInfo sharedSingleton].serverName ,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner, [SplusUser sharedSingleton].uid, _money, _strPayWay, mTime, [AppInfo sharedSingleton].gameKey];
        
        NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                    [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                    [AppInfo sharedSingleton].sourceID,@"referer",
                                    partner, @"partner",
                                    [SplusUser sharedSingleton].uid, @"uid",
                                    [SplusUser sharedSingleton].username, @"passport",//用户名
                                    [OrderInfo sharedSingleton].serverName, @"serverName",//游戏服名
                                    [OrderInfo sharedSingleton].roleName, @"roleName",//充值角色
                                    _money, @"money",
                                    [OrderInfo sharedSingleton].type, @"type",//充值方式0 非定额 1 定额
                                    _strPayWay, @"payway",
                                    mTime, @"time",
                                    [MyMD5 md5:sign], @"sign",
                                    @"1",@"debug",
                                    [OrderInfo sharedSingleton].pext, @"pext",nil];
        
        NSString *postData = [dictionary buildQueryString];
        
        NSLog(@"last post =%@", [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData]);
        _payDelegateUrl = [_payUrl stringByAppendingFormat:@"%@%@", @"?", postData];
    
    if (_payway == 1 || _payway == 3) {
        PayWebView *paywebHtml = [[PayWebView alloc] init];
        paywebHtml.payway = _payway;
        paywebHtml.webUrl = _payDelegateUrl;
        [self presentModalViewController:paywebHtml animated:YES];
    }
    else
    {
        [_aliPost post:_payUrl argData:postData];
    }
}

-(void)unin_callback:(NSString*)tempResult
{
    [_HUD hide:YES];
    NSLog(@"alipay result = %@", tempResult);
    NSDictionary *aliFirstResult = [tempResult JSONValue];
    NSString *isSuccess = [aliFirstResult objectForKey:@"code"];
    NSDictionary *dataDict = [aliFirstResult objectForKey:@"data"];

    [OrderInfo sharedSingleton].transNum = [dataDict objectForKey:@"orderid"];
    _aliUrl = [dataDict objectForKey:@"orderinfo"];
    
    [UPPayPlugin startPay:_aliUrl mode:@"00" viewController:self delegate:self];//银联支付
}


-(void)alipayKuai_callback:(NSString *)tempResult{
    
    [_HUD hide: YES];
    NSLog(@"alipay result = %@", tempResult);
    NSDictionary *aliFirstResult = [tempResult JSONValue];
    NSString *isSuccess = [aliFirstResult objectForKey:@"code"];
    
    if ([isSuccess intValue] != 24) {
        NSString *body = [aliFirstResult objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:body delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }

    NSDictionary *dataDict = [aliFirstResult objectForKey:@"data"];
    [OrderInfo sharedSingleton].transNum = [dataDict objectForKey:@"orderid"];
    _aliUrl = [dataDict objectForKey:@"orderinfo"];
    AlixPay * alixpay = [AlixPay shared];
    NSString *appScheme = @"SplusAlipay:";
    appScheme = [appScheme stringByAppendingFormat:@"%@",[SplusUser sharedSingleton].uid];
    int ret = [alixpay pay:_aliUrl applicationScheme:appScheme];
    if (ret == kSPErrorAlipayClientNotInstalled) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
        [alertView setTag:123];
        [alertView show];
    }else if (ret == kSPErrorSignError){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"签名错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

//银联支付callback
- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"unicom callback = %@", result);
    
    if ([result isEqualToString:@"success"]) {
        //银联支付成功 callback给 CP
    }
    else if([result isEqualToString:@"fail"])
    {
        //银联支付失败 callback给 CP
    }else if([result isEqualToString:@"cancel"])
    {
        //银联支付取消 callback给 CP
    }
    [self showAlertMessage:result];
}


- (void)showAlertMessage:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
    if ([textField.text length] != 0) {
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"splus_cash_bg"] forState:UIControlStateNormal];
        _money = _FlastSelectbutton.titleLabel.text;
    }
    else
    {
        _money = textField.text;
    }
    
    self.view.frame =CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
