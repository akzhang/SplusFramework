//
//  PayManual.m
//  SplusFramework
//
//  Created by akzhang on 14-6-27.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "PayManual.h"

@interface PayManual ()

@end

@implementation PayManual

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
    [self initPayManual];
    
    if (_orientation != UIDeviceOrientationPortrait)
    {
        [self initPayManualLand];
    }
    
    // Do any additional setup after loading the view.
}

-(void)initPayManual
{
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 30)];
    _splusPayText.text = @"人工充值";
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
    
    _splusChooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 50, 200, 30)];
    _splusChooseLabel.text = @"请选择对应的开户银行";
    _splusChooseLabel.font = [UIFont systemFontOfSize:15.0];
    _splusChooseLabel.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusChooseLabel];
    
    _splusFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, SCREENWIDTH - 20, 250)];
    [_splusFrameView setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    _splusFrameView.userInteractionEnabled = YES;
    [_splusFrameView setClipsToBounds:YES];
    [self.view addSubview:_splusFrameView];
    
    _splusUnderLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 36, SCREENWIDTH - 20, 1)];
    _splusUnderLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [_splusFrameView addSubview:_splusUnderLine];
    
#pragma mark -Frame
    
    //工商银行
    _icbc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4 - 5, 35)];
    [_icbc setTitle:@"工商银行" forState:UIControlStateNormal];
    _icbc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_icbc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _icbc.tag = 1;
    [_icbc addTarget:self action:@selector(splusBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusFrameView addSubview:_icbc];
    
    //招商银行
    _cmbc = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/4 - 5, 0, SCREENWIDTH/4 - 5, 35)];
    [_cmbc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_cmbc setTitle:@"招商银行" forState:UIControlStateNormal];
    _cmbc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _cmbc.tag = 2;
    [_cmbc addTarget:self action:@selector(splusBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusFrameView addSubview:_cmbc];
    
    //建设银行
    _ccb = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 10, 0, SCREENWIDTH/4 - 5, 35)];
    [_ccb setTitle:@"建设银行" forState:UIControlStateNormal];
    _ccb.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _ccb.tag = 3;
    [_ccb setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_ccb addTarget:self action:@selector(splusBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusFrameView addSubview:_ccb];
    
    //农业银行
    _abc = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH*3/4 - 15, 0, SCREENWIDTH/4 - 5, 35)];
    [_abc setTitle:@"农业银行" forState:UIControlStateNormal];
    _abc.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _abc.tag = 4;
    [_abc setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_abc addTarget:self action:@selector(splusBankClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusFrameView addSubview:_abc];
    
    _splusLocation = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 45, 260, 30)];
    _splusLocation.text = @"开户地: 广州";
    _splusLocation.font = [UIFont systemFontOfSize:15.0];
    _splusLocation.textColor = UIColorFromRGB(0x999999);
    [_splusFrameView addSubview:_splusLocation];
    
    _splusBankName = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 85, 260, 30)];
    _splusBankName.text = @"开户行: 建设银行广州工业园支行";
    _splusBankName.font = [UIFont systemFontOfSize:15.0];
    _splusBankName.textColor = UIColorFromRGB(0x999999);
    [_splusFrameView addSubview:_splusBankName];
    
    _splusBankAcount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 125, 260, 30)];
    _splusBankAcount.text = @"账   号: 广州灿和信息科技有限公司";
    _splusBankAcount.font = [UIFont systemFontOfSize:15.0];
    _splusBankAcount.textColor = UIColorFromRGB(0x999999);
    [_splusFrameView addSubview:_splusBankAcount];
    
    _splusCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 130, 165, 260, 30)];
    _splusCardLabel.text = @"卡   号: 44001 47051 30530 06982";
    _splusCardLabel.font = [UIFont systemFontOfSize:15.0];
    _splusCardLabel.textColor = UIColorFromRGB(0xff6600);
    [_splusFrameView addSubview:_splusCardLabel];
    
//    _splusCardNum = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 + 130, 165, 260, 30)];
//    _splusCardNum.text = @"44001 47051 30530 06982";
//    _splusCardNum.font = [UIFont systemFontOfSize:15.0];
//    _splusCardNum.textColor = UIColorFromRGB(0xff6600);
//    [_splusFrameView addSubview:_splusCardNum];
    
    _splusTip = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, 200, 20, 20)];
    _splusTip.image = [GetImage getSmallRectImage:@"splus_pay_warning"];
    [_splusFrameView addSubview:_splusTip];
    
    _splusTibPayBt = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 200, 50, 20)];
    [_splusTibPayBt setTitle:@"充值说明" forState:UIControlStateNormal];
    [_splusTibPayBt setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    _splusTibPayBt.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_splusTibPayBt addTarget:self action:@selector(yyPayBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusFrameView addSubview:_splusTibPayBt];
    
    
    _splusCoustomNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, 150, 30)];
    _splusCoustomNum.text = @"客服电话: 020-85166576";
    _splusCoustomNum.font = [UIFont systemFontOfSize:12.0];
    _splusCoustomNum.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusCoustomNum];
    
    _splusQQ = [[UILabel alloc] initWithFrame:CGRectMake(160, 350, 150, 30)];
    _splusQQ.text = @"客服QQ: 23355700639";
    _splusQQ.font = [UIFont systemFontOfSize:12.0];
    _splusQQ.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusQQ];
    
    _splusWeixin = [[UILabel alloc] initWithFrame:CGRectMake(10, 390, 150, 30)];
    _splusWeixin.text = @"客服微信: yxsplus";
    _splusWeixin.font = [UIFont systemFontOfSize:12.0];
    _splusWeixin.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusWeixin];
    
    _splusCustomTime = [[UILabel alloc] initWithFrame:CGRectMake(160, 390, 150, 30)];
    _splusCustomTime.text = @"服务时间: 09:00 - 24:00";
    _splusCustomTime.font = [UIFont systemFontOfSize:12.0];
    _splusCustomTime.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusCustomTime];
    
}

#pragma mark -Land
-(void)initPayManualLand
{
    [_back setFrame:CGRectMake(5, 2, 50, 30)];
    
    [_splusPayText setFrame:CGRectMake(SCREENWIDTH/2 - 40, 2, 80, 30)];
    
    [_custom setFrame:CGRectMake(SCREENWIDTH - 55, 2, 50, 30)];
    
    [_splusSplitLine setFrame:CGRectMake(0, 32, SCREENWIDTH, 1)];
    
    [_splusChooseLabel setFrame:CGRectMake(SCREENWIDTH/2 - 100, 35, 200, 20)];
    
    [_splusFrameView setFrame:CGRectMake(10, 60, SCREENWIDTH - 20, 200)];
    
    [_splusUnderLine setFrame:CGRectMake(0, 30, SCREENWIDTH - 20, 1)];
    
    [_icbc setFrame:CGRectMake(0, 0, SCREENWIDTH/4 - 5, 35)];
    [_cmbc setFrame:CGRectMake(SCREENWIDTH/4 - 5, 0, SCREENWIDTH/4 - 5, 35)];
    [_ccb setFrame:CGRectMake(SCREENWIDTH/2 - 10, 0, SCREENWIDTH/4 - 5, 35)];
    [_abc setFrame:CGRectMake(SCREENWIDTH*3/4 - 15, 0, SCREENWIDTH/4 - 5, 35)];
    
#pragma mark -Frame
    [_splusLocation setFrame:CGRectMake(SCREENWIDTH/2 - 130, 40, 260, 20)];
    [_splusBankName setFrame:CGRectMake(SCREENWIDTH/2 - 130, 65, 260, 20)];
    [_splusBankAcount setFrame:CGRectMake(SCREENWIDTH/2 - 130, 90, 260, 20)];
    [_splusCardLabel setFrame:CGRectMake(SCREENWIDTH/2 - 130, 115, 260, 20)];
    
    [_splusTip setFrame:CGRectMake(self.view.frame.size.width - 120, 140, 20, 20)];
    [_splusTibPayBt setFrame:CGRectMake(self.view.frame.size.width - 100, 140, 50, 20)];
    
    [_splusCoustomNum setFrame:CGRectMake(10, 265, 150, 20)];
    [_splusQQ setFrame:CGRectMake(SCREENWIDTH/2, 265, 150, 30)];
    [_splusWeixin setFrame:CGRectMake(10, 290, 150, 20)];
    [_splusCustomTime setFrame:CGRectMake(SCREENWIDTH/2, 290, 150, 20)];
}

-(void)splusBankClick:(id)sender
{
    if (_FlastSelectbutton) {//是否最后一次选中
        [_FlastSelectbutton setBackgroundImage:[GetImage getSmallRectImage:@"splus_cash_bg"] forState:UIControlStateNormal];
    }
    UIButton *AButton=sender;
    [AButton setBackgroundImage:[GetImage getPayRectImage:@"splus_pay_choose"] forState:UIControlStateNormal];
    _FlastSelectbutton=AButton;
    
    switch (_FlastSelectbutton.tag) {
        case 1:
            _splusBankName.text = @"开户行: 工商银行广州工业园支行";
            break;
            
        case 2:
            _splusBankName.text = @"开户行: 招商银行广州工业园支行";
            break;
            
        case 3:
            _splusBankName.text = @"开户行: 建设银行广州工业园支行";
            break;
            
        case 4:
            _splusBankName.text = @"开户行: 农业银行广州工业园支行";
            break;
            
        default:
            break;
    }
}

//back
-(void)yyPayBackClick
{
    [self dismissViewControllerAnimated:NO completion:nil];//支付取消callback
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
