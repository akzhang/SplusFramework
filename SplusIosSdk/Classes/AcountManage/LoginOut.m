//
//  LoginOut.m
//  SplusFramework
//
//  Created by akzhang on 14-7-10.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "LoginOut.h"

@interface LoginOut ()

@end

@implementation LoginOut

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
    
    _back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 40)];
    [_back setImage:[GetImage imagesNamedFromCustomBundle:@"splus_back"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(yyAcountBackClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_back];
    
    _splusPayText = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 3, 80, 50)];
    _splusPayText.text = @"账户注销";
    _splusPayText.font = [UIFont systemFontOfSize:20.0];
    _splusPayText.textColor = UIColorFromRGB(0xff6600);
    [self.view addSubview:_splusPayText];
    
    _custom = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 5, 50, 50)];
    [_custom setImage:[GetImage imagesNamedFromCustomBundle:@"splus_custom"] forState:UIControlStateNormal];
    [_custom addTarget:self action:@selector(yyAcountCustomClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_custom];
    
    _splusSplitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
    _splusSplitLine.image = [GetImage imagesNamedFromCustomBundle:@"splus_split_line"];
    [self.view addSubview:_splusSplitLine];
    
    _splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 65, 40, 20)];
    _splusTitle.text = @"尊敬的:";
    _splusTitle.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:_splusTitle];
    
    _splusUserName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 60, 20)];
    _splusUserName.text = [SplusUser sharedSingleton].username;
    _splusUserName.font = [UIFont systemFontOfSize:12.0];
    _splusUserName.textColor = [UIColor orangeColor];
    [self.view addSubview:_splusUserName];
    
    _splusPlay = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, 65, 80, 20)];
    _splusPlay.text = [SplusUser sharedSingleton].username;
    _splusPlay.font = [UIFont systemFontOfSize:12.0];
    _splusPlay.textColor = [UIColor orangeColor];
    [self.view addSubview:_splusPlay];
    
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 90, SCREENHEIGHT/2 - 50, 180, 100)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    [self.view addSubview:splusEditFrame];
    
    _splusLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    _splusLogo.image = [GetImage imagesNamedFromCustomBundle:@"splus_float_icon_normal"];
    [splusEditFrame addSubview:_splusLogo];
    
    
    _splusGameId = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 120, 20)];
    _splusGameId.text = @"游戏名称:剑灵天下";
    _splusGameId.font = [UIFont systemFontOfSize:12.0];
    _splusGameId.backgroundColor = [UIColor clearColor];
    _splusGameId.textColor = [UIColor orangeColor];
    [splusEditFrame addSubview:_splusGameId];
    
    _spluGameVersion = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, 120, 20)];
    _spluGameVersion.text = @"游戏版本:1.0";
    _spluGameVersion.backgroundColor = [UIColor clearColor];
    _spluGameVersion.font = [UIFont systemFontOfSize:12.0];
    _spluGameVersion.textColor = [UIColor orangeColor];
    [splusEditFrame addSubview:_spluGameVersion];
    
    _splusLoginOutButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 90, SCREENHEIGHT/2 + 70, 180, 50)];
    [_splusLoginOutButton setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusLoginOutButton setTitle:@"确  定" forState:UIControlStateNormal];
    _splusLoginOutButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusLoginOutButton addTarget:self action:@selector(splusLoginOutClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [self.view addSubview:_splusLoginOutButton];
    
//    _splusLoginOutButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 55, SCREENHEIGHT/2 + 70, 180, 50)];
//    [_splusLoginOutButton setImage:[GetImage imagesNamedFromCustomBundle:@"splus_login_bt"] forState:UIControlStateNormal];
//    [_splusLoginOutButton setTitle:@"确定" forState:UIControlStateNormal];
//    _splusLoginOutButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [_splusLoginOutButton addTarget:self action:@selector(yyLoginOutClick) forControlEvents: UIControlEventTouchUpInside];//处理点击
//    [self.view addSubview:_splusLoginOutButton];
    
    // Do any additional setup after loading the view.
}

-(void)yyAcountBackClick
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)yyAcountCustomClick
{
    [self dismissModalViewControllerAnimated:YES];
}


-(void)splusLoginOutClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter  defaultCenter]postNotificationName:@"LoginOut_close" object:nil];
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
