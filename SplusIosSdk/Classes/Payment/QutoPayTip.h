//
//  QutoPayTip.h
//  SplusFramework
//
//  Created by akzhang on 14-7-9.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"

@interface QutoPayTip :UIView// UIViewController

@property (strong, nonatomic) IBOutlet UIView *splusTipBgView;//设置背景图

@property (strong, nonatomic) IBOutlet UIImageView *splusTipBgImageView;//设置背景图

@property (strong, nonatomic) IBOutlet UIButton *splusTipBt;//按钮

@property (strong, nonatomic) IBOutlet UIButton *close;//关闭

@property (strong, nonatomic) IBOutlet UIImageView *splusSpliterLine;//分割线

@property(strong, nonatomic)UITextView *tipContent;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)NSString *tipString;

@end
