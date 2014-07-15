//
//  ModifyPwd.m
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "ModifyPwd.h"

@interface ModifyPwd ()

@end

@implementation ModifyPwd

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
//    _orientation = [UIApplication sharedApplication].statusBarOrientation;
//    [self initModifyView];
//    // Do any additional setup after loading the view.
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        [self initModifyView];
    }
    return self;
}

-(void)initModifyView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor darkTextColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    _splusModifyBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    [self addSubview:_splusModifyBgView];
    
    _splusModifyBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusModifyBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusModifyBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusModifyBgView addSubview:_splusModifyBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 45, 25, 100, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:15.0];
    splusTitle.text = @"修改密码";
    [_splusModifyBgView addSubview:splusTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(splusCloseClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusModifyBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusModifyBgView addSubview:_splusSpliterLine];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 280, 150)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [_splusModifyBgView addSubview:splusEditFrame];
    
    //旧密码
    _splusOldPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, 280, 50)];
    _splusOldPwd.placeholder = @" 请输入旧的账号密码";
    _splusOldPwd.font = [UIFont systemFontOfSize:14.0];
    _splusOldPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusOldPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _splusOldPwd.delegate = self;
    [_splusModifyBgView addSubview:_splusOldPwd];
    
    UIImageView* inputSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 278, 1)];
    [inputSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusModifyBgView addSubview:inputSpliterLine];
    
    //新密码
    _splusNewPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 50)];
    _splusNewPwd.placeholder = @" 密码:6-20位字母、数字、下划线“_”";
    _splusNewPwd.delegate = self;
    [_splusNewPwd setSecureTextEntry:TRUE];
    _splusNewPwd.font = [UIFont systemFontOfSize:14.0];
    _splusNewPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusNewPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_splusModifyBgView addSubview:_splusNewPwd];
    
    UIImageView* secondSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(20, 170, 278, 1)];
    [secondSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusModifyBgView addSubview:secondSpliterLine];
    
    //重复密码
    _splusRepeatPwd = [[UITextField alloc] initWithFrame:CGRectMake(20, 170, 280, 50)];
    _splusRepeatPwd.placeholder = @" 再输入一遍新密码";
    _splusRepeatPwd.delegate = self;
    [_splusRepeatPwd setSecureTextEntry:TRUE];
    _splusRepeatPwd.font = [UIFont systemFontOfSize:14.0];
    _splusRepeatPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _splusRepeatPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_splusModifyBgView addSubview:_splusRepeatPwd];

    
    //立即登录
    _splusModifyBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 280, 35)];
    [_splusModifyBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusModifyBt setTitle:@"提交修改" forState:UIControlStateNormal];
    _splusModifyBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusModifyBt addTarget:self action:@selector(splusModifyClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusModifyBgView addSubview:_splusModifyBt];
}

-(void)splusModifyClick:(id)sender
{
    NSString *oldPwd = _splusOldPwd.text;
    NSString *newPwd = _splusNewPwd.text;
    NSString *rePwd = _splusRepeatPwd.text;
    
    if ([oldPwd length] == 0) {
        [self showMessage:@"请输入原来密码"];
        return;
    }
    
    if ([newPwd length] == 0 || [newPwd length] < 6) {
        [self showMessage:@"您的密码不符合要求"];
        return;
    }
    
    if (![newPwd isEqualToString:rePwd]) {
        [self showMessage:@"两次输入密码不一致"];
        return;
    }
    
    _HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:_HUD];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.labelText = @"加载中，请稍后...";
    [_HUD show: YES];
    
    _aliPost = [[httpRequest alloc] init];
    _aliPost.dlegate = self;
    _aliPost.success = @selector(modify_callback:);
    _aliPost.error = @selector(modify_error);
    
    // 登录请求
    NSDictionary *dictionaryBundle = [[NSBundle mainBundle] infoDictionary];
    NSString *partner = [dictionaryBundle objectForKey:@"Partner"];
    NSString *sign = @"";
    NSString *mTime = [[AppInfo sharedSingleton] getData];
    NSLog(@"deviceno = %@", [ActivateInfo sharedSingleton].deviceno);
    
    sign = [sign stringByAppendingFormat:@"%@%@%@%@%@%@%@%@%@%@", [AppInfo sharedSingleton].gameID,[ActivateInfo sharedSingleton].deviceno,[AppInfo sharedSingleton].sourceID, partner,[SplusUser sharedSingleton].uid, [SplusUser sharedSingleton].username, mTime, oldPwd, newPwd,[AppInfo sharedSingleton].gameKey];
    
    NSLog(@"Md5 sign = %@", [MyMD5 md5:sign]);
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [SplusUser sharedSingleton].uid, @"uid",
                                @"1",@"debug",
//                                [OrderInfo sharedSingleton].serverName, @"serverName",//游戏服名
                                [AppInfo sharedSingleton].gameID, @"gameid",
                                [MyMD5 md5:sign], @"sign",
                                mTime, @"time",
                                [ActivateInfo sharedSingleton].deviceno, @"deviceno",
                                partner, @"partner",
                                [AppInfo sharedSingleton].sourceID,@"referer",
                                [SplusUser sharedSingleton].username, @"passport",//用户名
                                oldPwd, @"oldp",//充值角色
                                newPwd, @"newp",nil];
    
    NSString *postData = [dictionary buildQueryString];
    
    NSLog(@"postData modify=%@", [MODIFY_PWD stringByAppendingFormat:@"%@", postData]);
    
    [_aliPost post:MODIFY_PWD argData:postData];

}

-(void)modify_callback:(NSString*)result
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    NSLog(@"login info result = %@", result);//登录信息
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rootDic = [parser objectWithString:result];
    NSString *code = [rootDic objectForKey:@"code"];
    
    if ([code intValue] == 1)
    {
        //登录成功，callback
//        [self dismissModalViewControllerAnimated:YES];//修改成功callback
        [self removeFromSuperview];
    }
    else
    {
        [self showMessage:[rootDic objectForKey:@"msg"]];
    }
}

-(void)modify_error
{
    if (_HUD != NULL) {
        [_HUD hide:YES];
    }
    
    [self showMessage:@"网络连接超时"];
}

-(void)splusCloseClick
{
//    [self dismissModalViewControllerAnimated:YES];
    [self removeFromSuperview];
}

-(void)showMessage:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma -mark UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {//如果机型是iPhone
        
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            offset = frame.origin.y + 200 - (self.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 180 - (self.frame.size.height -216.0);
        }
        
    }else{//机型是ipad
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            offset = frame.origin.y + 100 - (self.frame.size.height -216.0);
        }else{
            offset = frame.origin.y + 190 - (self.frame.size.height -216.0);
        }
        
    }
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        if (_orientation == UIDeviceOrientationPortrait) {//是竖屏
            self.frame =CGRectMake(0.0f, -offset,self.frame.size.width,self.frame.size.height);//-offset 0.0f
        }else{
            self.frame =CGRectMake(offset, 0.0f,self.frame.size.width,self.frame.size.height);//-offset 0.0f
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
    self.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
}

//触摸view隐藏键盘——touchDown

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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
