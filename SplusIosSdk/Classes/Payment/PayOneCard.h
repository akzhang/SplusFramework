//
//  PayOneCard.h
//  SplusFramework
//
//  Created by akzhang on 14-6-26.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"

@interface PayOneCard : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//payway
@property(nonatomic, strong)UILabel *splusPayWayText;

@property(nonatomic, strong)UILabel *splusPayValue;

//请选择充值金额
@property(nonatomic, strong)UILabel *splusCashValue;

//元宝兑换
@property(nonatomic, strong)UIButton *splusExchangeBt;

//确定充值
@property(nonatomic, strong)UIButton *splusCommit;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

//splus注意
@property(nonatomic, strong)UILabel *splusTipLabel;

@property(nonatomic, strong)NSArray *cashArray;

@property(nonatomic, strong)UIImageView *splusEditFrame;

@property(nonatomic, strong)UIImageView *inputSpliterLine;

// 卡号
@property(nonatomic, strong)UITextField *splusCardNum;

// 密码
@property(nonatomic, strong)UITextField *splusCardPwd;

@property(nonatomic, strong)UIScrollView *splusScrollView;

@end
