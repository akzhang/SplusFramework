//
//  PayManual.h
//  SplusFramework
//
//  Created by akzhang on 14-6-27.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"

@interface PayManual : UIViewController

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//bank
@property(nonatomic, strong)UILabel *splusChooseLabel;

@property(nonatomic, strong)UIImageView *splusFrameView;

@property(nonatomic, strong)UIButton *icbc;//工商银行

@property(nonatomic, strong)UIButton *cmbc;//招商银行

@property(nonatomic, strong)UIButton *ccb;//建设银行

@property(nonatomic, strong)UIButton *abc;//农业银行

@property(nonatomic, strong)UIImageView *splusUnderLine;//下划线

@property(nonatomic, strong)UILabel *splusLocation;

@property(nonatomic, strong)UILabel *splusBankName;

@property(nonatomic, strong)UILabel *splusBankAcount;

@property(nonatomic, strong)UILabel *splusCardLabel;//卡号label

@property(nonatomic, strong)UILabel *splusCardNum;//卡号

@property(nonatomic, strong)UILabel *splusCoustomNum;

@property(nonatomic, strong)UILabel *splusQQ;

@property(nonatomic, strong)UILabel *splusWeixin;

@property(nonatomic, strong)UILabel *splusCustomTime;

@property(nonatomic, strong)UIImageView *splusTip;

@property(nonatomic, strong)UIButton *splusTibPayBt;

@property(nonatomic, strong)UIButton *FlastSelectbutton;//是否是最后一次选中

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, assign)int payway;

@end
