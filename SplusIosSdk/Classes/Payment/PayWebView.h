//
//  PayWebView.h
//  SplusFramework
//
//  Created by akzhang on 14-7-3.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpUrl.h"
#import "GetImage.h"
#import "MBProgressHUD.h"

@interface PayWebView : UIViewController<UIWebViewDelegate>

@property(nonatomic, strong)UIButton *back;

@property(nonatomic, strong)UILabel *splusPayText;

@property(nonatomic, strong)UIButton *custom;

@property(nonatomic, strong)UIWebView *webView;

//分割线
@property(nonatomic, strong)UIImageView *splusSplitLine;

@property(nonatomic, assign)int payway;

@property(nonatomic, strong)NSString *webUrl;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end
