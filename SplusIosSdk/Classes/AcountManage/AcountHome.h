//
//  AcountHome.h
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetImage.h"
#import "HttpUrl.h"
#import "AcountCell.h"
#import "SplusCallback.h"
#import "SafeHome.h"
#import "AcountWeb.h"
#import "LoginOut.h"

@interface AcountHome : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)id<SplusCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *splusWelText;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

@property(nonatomic, strong)UILabel *splusTitle;

@property(nonatomic, strong)UILabel *splusUserName;

@property(nonatomic, strong)UILabel *splusWel;

@property(nonatomic, strong)UITableView *splusTableView;

@property(nonatomic, strong)NSArray *splusArray;

@property(nonatomic, strong)NSArray *splusImageArray;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
