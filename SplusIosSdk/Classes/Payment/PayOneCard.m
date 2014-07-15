//
//  PayOneCard.m
//  SplusFramework
//
//  Created by akzhang on 14-6-26.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "PayOneCard.h"

@interface PayOneCard ()

@end

@implementation PayOneCard

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

-(void)initPayValue
{
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 30)];

    switch (_payway) {
        case 4:
            _splusPayText.text = @"移动卡";
            _paySource = CHAIN_CMM_PAYWAY;
            break;
        case 5:
            _splusPayText.text = @"联通卡";
            _paySource = CHAIN_UNC_PAYWAY;
            break;
            
        case 6:
            _splusPayText.text = @"盛大卡";
            _paySource = CHAIN_SD_PAYWAY;
            break;
            
        default:
            _splusPayText.text = @"储蓄卡";
            _paySource = CHAIN_CMM_PAYWAY;
            break;
    }
    
    _splusPayText.font = [UIFont systemFontOfSize:15.0];
    _splusPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 30)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyPayBackClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    

#pragma mark -ScrollView
    _splusScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, SCREENWIDTH, SCREENHEIGHT - 60)];
    _splusScrollView.pagingEnabled = YES;
    _splusScrollView.delegate = self;
    _splusScrollView.showsVerticalScrollIndicator = NO;
    _splusScrollView.showsHorizontalScrollIndicator = NO;
    
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        CGSize newSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 100);
        [_splusScrollView setContentSize:newSize];
    }
    else
    {
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
        [_splusScrollView setContentSize:newSize];
    }
    
    
    
    [self.view addSubview:_splusScrollView];
    
    _splusPayWayText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 140, 30)];
    _splusPayWayText.text = @"您选择的充值方式为:";
    _splusPayWayText.font = [UIFont systemFontOfSize:14.0];
    _splusPayWayText.textColor = UIColorFromRGB(0x999999);
    [_splusScrollView addSubview:_splusPayWayText];
    
    _splusPayValue = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 80, 30)];
//    _splusPayValue.text = @"支付宝";
    _splusPayValue.text = _headTitle;
    _splusPayValue.font = [UIFont systemFontOfSize:15.0];
    _splusPayValue.textColor = UIColorFromRGB(0x666666);
    [_splusScrollView addSubview:_splusPayValue];
    
    
    _splusCashValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 200, 30)];
    _splusCashValue.text = @"请选择充值金额:";
    _splusCashValue.font = [UIFont systemFontOfSize:14.0];
    _splusCashValue.textColor = UIColorFromRGB(0x666666);
    [_splusScrollView addSubview:_splusCashValue];
    
    
#pragma mark -InitButton
    if (_orientation != UIDeviceOrientationPortrait)
    {//横竖屏button布局
        [self initWithLandButton];
    }
    else
    {
        [self initWithButton];
    }
    
    _splusTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 245, SCREENWIDTH - 30, 30)];
    _splusTipLabel.textColor = UIColorFromRGB(0xff6600);
    _splusTipLabel.text = @"注:请选择与充值金额等值的充值卡";
    _splusTipLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusScrollView addSubview:_splusTipLabel];
    
    //交换
    _splusExchangeBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 285, SCREENWIDTH - 30, 45)];
    [_splusExchangeBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_value_bg"] forState:UIControlStateNormal];
    [_splusExchangeBt setTitle:@"50元可兑换350个元宝" forState:UIControlStateNormal];
    _splusExchangeBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusExchangeBt addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    _splusExchangeBt.userInteractionEnabled = NO;
    [_splusScrollView addSubview:_splusExchangeBt];
    
     _splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(15, 340, SCREENWIDTH - 30, 100)];
    [_splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [_splusScrollView addSubview:_splusEditFrame];
    
    //用户名
    _splusCardNum = [[UITextField alloc] initWithFrame:CGRectMake(15, 340, SCREENWIDTH - 30, 50)];
    _splusCardNum.placeholder = @" 请输入卡号";
    _splusCardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusCardNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _splusCardNum.delegate = self;
    [_splusScrollView addSubview:_splusCardNum];
    
    _inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, 390, SCREENWIDTH - 30, 1)];
    [_inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusScrollView addSubview:_inputSpliterLine];
    
    //密码
    _splusCardPwd = [[UITextField alloc] initWithFrame:CGRectMake(15, 390, SCREENWIDTH - 30, 50)];
    _splusCardPwd.placeholder = @" 请输入充值卡密码";
    _splusCardPwd.delegate = self;
    [_splusCardPwd setSecureTextEntry:TRUE];
    _splusCardPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusCardPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_splusScrollView addSubview:_splusCardPwd];
    
    _splusTip = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 120, 450, 20, 20)];
    _splusTip.image = [GetImage getSmallRectImage:@"splus_pay_warning"];
    [_splusScrollView addSubview:_splusTip];
    
    _splusTibPayBt = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 100, 450, 50, 20)];
    [_splusTibPayBt setTitle:@"充值说明" forState:UIControlStateNormal];
    [_splusTibPayBt setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _splusTibPayBt.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_splusTibPayBt addTarget:self action:@selector(yyPayTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusScrollView addSubview:_splusTibPayBt];
    
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, 475, SCREENWIDTH - 30, 50)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"确定充值" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    _splusCommit.userInteractionEnabled = NO;
    [_splusScrollView addSubview:_splusCommit];
}

//横屏
#pragma mark -Land
-(void)initPayValueLand
{
    [_back setFrame:CGRectMake(5, 2, 50, 30)];
    
    [_splusPayText setFrame:CGRectMake(SCREENWIDTH/2 - 40, 2, 80, 30)];
    
    [_custom setFrame:CGRectMake(SCREENWIDTH - 55, 2, 50, 30)];
    
    [_splusSplitLine setFrame:CGRectMake(0, 32, SCREENWIDTH, 1)];
    
    _splusScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 60)];
    
    [_splusPayWayText setFrame:CGRectMake(15, 0, 140, 20)];
    
    [_splusPayValue setFrame:CGRectMake(155, 0, 140, 20)];
    
    [_splusCashValue setFrame:CGRectMake(15, 30, 200, 20)];
    
    [_splusTipLabel setFrame:CGRectMake(15, 160, SCREENWIDTH - 30, 20)];
    
    //交换
    [_splusExchangeBt setFrame:CGRectMake(15, 190, SCREENWIDTH - 30, 45)];
    
    //卡号
    [_splusEditFrame setFrame:CGRectMake(15, 245, SCREENWIDTH - 30, 90)];
    
    //用户名
    [_splusCardNum setFrame:CGRectMake(15, 245, SCREENWIDTH - 30, 45)];
    
    [_inputSpliterLine setFrame:CGRectMake(15, 290, SCREENWIDTH - 30, 1)];
    
    //密码
    [_splusCardPwd setFrame:CGRectMake(15, 290, SCREENWIDTH - 30, 45)];
    
    [_splusTip setFrame:CGRectMake(SCREENWIDTH - 120, 340, 20, 20)];
    
    
    [_splusTibPayBt setFrame:CGRectMake(SCREENWIDTH - 100, 340, 50, 20)];
    
    [_splusCommit setFrame:CGRectMake(15, 365, SCREENWIDTH - 30, 45)];
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
                button.frame = CGRectMake(100*j - 85, 80, 90, 45);
            }
            else if(i == 2)//2
            {
                button.frame = CGRectMake(100*j - 85, 135, 90, 45);
            }
            else//3
            {
                button.frame = CGRectMake(100*j - 85, 190, 90, 45);
            }
            
            [_splusScrollView addSubview:button];
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
                button.frame = CGRectMake(90*j - 75, 60, 80, 40);
            }
            else//2行
            {
                button.frame = CGRectMake(90*j - 75, 110, 80, 40);
            }
            
            [_splusScrollView addSubview:button];
        }
    }
}

-(void)yyPayTipClick:(id)sender
{
    switch (_payway) {
        case 4:
            tipValue = YIDONG_SERVER;
            break;
        case 5:
            tipValue = LIANTONG_SERVER;
            break;
            
        case 6:
            tipValue = SHENGDA_SERVER;
            break;
            
        default:
            tipValue = SHENGDA_SERVER;
            break;
    }
    QutoPayTip *tip = [[QutoPayTip alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    [self.view addSubview:tip];
    
}

//back
-(void)yyPayBackClick:(id)sender
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
    if (_splusCardNum.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"卡号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(_splusCardNum.text.length > 25){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"卡号长度不能超过25" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(_splusCardPwd.text.length > 25){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"密码长度不能超过25" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(_splusCardPwd.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    
    switch (_payway) {
        case 4:
        {
            _strPayWay = CHAIN_CMM_PAYWAY;
            _payUrl = HTMLWAPPAY_URL;
        }
            break;
            
        case 5:
        {
            _strPayWay = CHAIN_UNC_PAYWAY;
            _payUrl = HTMLWAPPAY_URL;
        }
            break;
            
        case 6:
        {
            _strPayWay = CHAIN_SD_PAYWAY;
            _payUrl = HTMLWAPPAY_URL;
            _aliPost.success = @selector(deposit_callback:);//payPostStr
            
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

    _money = _FlastSelectbutton.titleLabel.text;

    
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
    
    PayWebView *paywebHtml = [[PayWebView alloc] init];
    paywebHtml.payway = _payway;
    paywebHtml.webUrl = _payDelegateUrl;
    [self presentModalViewController:paywebHtml animated:YES];

}



- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![CoinRatio sharedSingleton].ratio)
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
}

-(void)coin_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络连接超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    return;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
