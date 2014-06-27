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
    [_back addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 30)];
    _splusPayText.text = @"充值中心";
    _splusPayText.font = [UIFont systemFontOfSize:15.0];
    _splusPayText.textColor = UIColorFromRGB(0x222222);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 30)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
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
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
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
    _splusPayValue.text = @"支付宝";
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
    
    _splusCommit = [[UIButton alloc] initWithFrame:CGRectMake(15, 450, SCREENWIDTH - 30, 50)];
    [_splusCommit setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusCommit setTitle:@"确定充值" forState:UIControlStateNormal];
    _splusCommit.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusCommit addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    _splusCommit.userInteractionEnabled = NO;
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
    
    [_splusCommit setFrame:CGRectMake(15, 345, SCREENWIDTH - 30, 45)];
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

-(void)selectCashButton:(id)sender
{
    
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
