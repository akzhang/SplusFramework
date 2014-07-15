//
//  LoginOut.h
//  SplusFramework
//
//  Created by akzhang on 14-7-10.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "SplusUser.h"
#import "SplusInterfaceKit.h"

@interface LoginOut : UIViewController

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *splusWelText;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@property(nonatomic, strong)UILabel *splusTitle;

@property(nonatomic, strong)UILabel *splusUserName;

@property(nonatomic, strong)UILabel *splusPlay;

@property(nonatomic, strong)UIImageView *splusLogo;

@property(nonatomic, strong)UILabel *splusGameId;

@property(nonatomic, strong)UILabel *spluGameVersion;

@property(nonatomic, strong)UIButton *splusLoginOutButton;

@end
