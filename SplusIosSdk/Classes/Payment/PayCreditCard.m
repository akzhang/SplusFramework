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
    _splusPayText.text = @"充值中心";
    _splusPayText.font = [UIFont systemFontOfSize:15.0];
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
    _splusPayValue.text = @"支付宝";
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
    [_splusCommit addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    _splusCommit.userInteractionEnabled = NO;
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

-(void)selectCashButton:(id)sender
{
        
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
