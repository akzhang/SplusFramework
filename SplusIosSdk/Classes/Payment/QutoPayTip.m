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

extern NSString *tipValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        [self initLoginView];
    }
    return self;
}

-(void)initLoginView
{
    CGFloat bg_width = 320;
    CGFloat bg_height = 290;
 
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor darkTextColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    _splusTipBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - bg_width/2, SCREENHEIGHT/2 - bg_height/2, bg_width, bg_height)];
    //    _splusLoginBgView.userInteractionEnabled = YES;
    [self addSubview:_splusTipBgView];
    
    _splusTipBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
    [_splusTipBgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_splusTipBgImageView setImage:[GetImage getRectImage:@"splus_login_bg"]];
    [_splusTipBgView addSubview:_splusTipBgImageView];
    
    
    UILabel *splusTitle = [[UILabel alloc] initWithFrame:CGRectMake(bg_width/2 - 80, 25, 160, 25)];
    splusTitle.textColor = UIColorFromRGB(0xFF6600);
    splusTitle.font = [UIFont systemFontOfSize:22.0];
    splusTitle.text = @"提示";
    [_splusTipBgView addSubview:splusTitle];
    
    _close = [[UIButton alloc] initWithFrame:CGRectMake(bg_width - 60, 15, 45, 45)];
    [_close setImage:[GetImage imagesNamedFromCustomBundle:@"splus_close"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(splusTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusTipBgView addSubview:_close];
    
    _splusSpliterLine = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 292, 1)];
    [_splusSpliterLine setImage:[GetImage imagesNamedFromCustomBundle:@"splus_split_line"]];
    [_splusTipBgView addSubview:_splusSpliterLine];
    
    UIImageView *splusEditFrame = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 280, 140)];
    [splusEditFrame setImage:[GetImage getSmallRectImage:@"splus_input_edit"]];
    splusEditFrame.userInteractionEnabled = YES;
    [_splusTipBgView addSubview:splusEditFrame];
    
    _tipContent = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 260, 120)];
    _tipContent.userInteractionEnabled = YES;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[tipValue dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _tipContent.attributedText = attributedString;
    _tipContent.scrollEnabled = YES;
    [splusEditFrame addSubview:_tipContent];
    
    
    //立即登陆
    _splusTipBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 280, 35)];
    [_splusTipBt setBackgroundImage:[GetImage getSmallRectImage:@"splus_login_bt"] forState:UIControlStateNormal];
    [_splusTipBt setTitle:@"确定" forState:UIControlStateNormal];
    _splusTipBt.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_splusTipBt addTarget:self action:@selector(splusTipClick:) forControlEvents: UIControlEventTouchUpInside];//处理点击
    [_splusTipBgView addSubview:_splusTipBt];
}

-(void)splusTipClick:(id)sender
{
    [self removeFromSuperview];
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
