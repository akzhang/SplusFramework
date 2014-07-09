//
//  QutoPayTip.m
//  SplusFramework
//
//  Created by akzhang on 14-7-9.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "QutoPayTip.h"

@interface QutoPayTip ()

@end

@implementation QutoPayTip

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
    
    // Do any additional setup after loading the view.
}

-(void)initLoginView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
    
    _splusTipBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    //    _splusLoginBgView.userInteractionEnabled = YES;
    [self.view addSubview:_splusTipBgView];
    
    _splusTipBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusTipBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusTipBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusTipBgView addSubview:_splusTipBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 80, 25, 160, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:22.0];
    splusTitle.text = @"充值提示";
    [_splusTipBgView addSubview:splusTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_splusTipBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusTipBgView addSubview:_splusSpliterLine];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 280, 100)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [_splusTipBgView addSubview:splusEditFrame];
    
    _tipContent = [[UITextView alloc] initWithFrame:CGRectMake(25, 70, 270, 90)];
    _tipContent.text = _tipString;
    [_splusTipBgView addSubview:_tipContent];
    
    
    //立即登陆
    _splusTipBt = [[UIButton alloc] initWithFrame:CGRectMake(165, 230, 135, 35)];
    [_splusTipBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusTipBt setTitle:@"确定" forState:UIControlStateNormal];
    _splusTipBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusTipBt addTarget:self action:@selector(splusLoginClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusTipBgView addSubview:_splusTipBt];
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
