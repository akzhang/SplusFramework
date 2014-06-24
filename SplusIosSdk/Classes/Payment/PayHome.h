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

@interface PayHome : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *close;

@property(nonatomic, strong)UILabel *splusWelText;

//用户名
@property(nonatomic, strong)UILabel *splusUserName;

@property(nonatomic, strong)UILabel *splusChooseWay;

//支付方式
@property(nonatomic, strong)UICollectionView *splusPayWayCollection;


@end
