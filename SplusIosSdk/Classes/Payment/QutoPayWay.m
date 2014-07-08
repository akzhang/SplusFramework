//
//  QutoPayWay.m
//  SplusFramework
//
//  Created by akzhang on 14-7-4.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "QutoPayWay.h"

@interface QutoPayWay ()

@end

@implementation QutoPayWay

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
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    [self initPayValue];
    
    // Do any additional setup after loading the view.
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
    
    _splusMiddleFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, SCREENHEIGHT - 55)];
    [self.view addSubview:_splusMiddleFrame];
    
    NSString *splusCash = @"您充值的金额是:";
    splusCash = [splusCash stringByAppendingFormat:@"%@",[OrderInfo sharedSingleton].money];
    _splusCashValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 80, SCREENHEIGHT/2 - 110, 160, 30)];
    _splusCashValue.text = splusCash;
    _splusCashValue.textColor = UIColorFromRGB(0xff6600);
    [_splusMiddleFrame addSubview:_splusCashValue];
    
    //交换
    _splusExchangeBt = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREENHEIGHT/2 - 70, SCREENWIDTH - 30, 35)];
    [_splusExchangeBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_value_bg"] forState:UIControlStateNormal];
    //兑换率
    int mRatio = [CoinRatio sharedSingleton].ratio;
    NSString *money = [OrderInfo sharedSingleton].money;
    NSString *cashValue = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@元可以兑换%d元宝", money, [money intValue]*mRatio]];
    [_splusExchangeBt setTitle:@"50元可兑换350个元宝" forState:UIControlStateNormal];
    _splusExchangeBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusExchangeBt addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    _splusExchangeBt.userInteractionEnabled = NO;
    [_splusMiddleFrame addSubview:_splusExchangeBt];
    
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, SCREENHEIGHT/2 - 25, SCREENWIDTH - 30, 35)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"确定充值" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusCommitClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusMiddleFrame addSubview:_splusCommit];

}

-(void)splusCommitClick:(id)sender
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"加载中，请稍后...";
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
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID, [OrderInfo sharedSingleton].serverName ,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner, [SplusUser sharedSingleton].uid, [OrderInfo sharedSingleton].money, _strPayWay, mTime, [AppInfo sharedSingleton].gameKey];
    
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[AppInfo sharedSingleton].gameID, @"gameid",
                                [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                [AppInfo sharedSingleton].sourceID,@"referer",
                                partner, @"partner",
                                [SplusUser sharedSingleton].uid, @"uid",
                                [SplusUser sharedSingleton].username, @"passport",//用户名
                                [OrderInfo sharedSingleton].serverName, @"serverName",//游戏服名
                                [OrderInfo sharedSingleton].roleName, @"roleName",//充值角色
                                [OrderInfo sharedSingleton].money, @"money",
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

-(void)alipayKuai_callback:(NSString *)tempResult{
    
    [_HUD hide: YES];
    NSLog(@"alipay result = %@", tempResult);
    NSDictionary *aliFirstResult = [tempResult JSONValue];
    NSString *isSuccess = [aliFirstResult objectForKey:@"code"];
    
//    if ([isSuccess intValue] != 24) {
//        NSString *body = [aliFirstResult objectForKey:@"msg"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:body delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
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

//back
-(void)yyPayBackClick
{
    [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
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
