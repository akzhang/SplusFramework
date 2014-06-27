//
//  PayHome.h
//  SplusFramework
//
//  Created by akzhang on 14-6-24.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionPayCell.h"
#import "HttpUrl.h"
#import "GetImage.h"
#import "SplusCallback.h"
#import "PSTCollectionView.h"
#import "PayCreditCard.h"
#import "PayOneCard.h"
#import "PayManual.h"

//,UICollectionViewDataSource, UICollectionViewDelegate
@interface PayHome : UIViewController<PSTCollectionViewDelegate,PSTCollectionViewDataSource>

//delegate
@property(nonatomic, retain)id<SplusCallback> delegate;

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UILabel *splusWelText;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

//用户名
@property(nonatomic, strong)UILabel *splusUserName;

@property(nonatomic, strong)UILabel *splusChooseWay;

//支付方式
@property(nonatomic, strong)PSUICollectionView *splusPayWayCollection;

//图片名字
@property(nonatomic, strong)NSArray *imageNameArray;
@property(nonatomic, strong)NSArray *imageNameArrayCh;

//方向
@property(nonatomic, assign)UIInterfaceOrientation orientation;


@end
