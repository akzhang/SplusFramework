//
//  HomeButton.h
//  YayawanIOS
//
//  Created by akzhang on 14-4-12.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeButton : UIButton{
    UIButton *imageBt;
    UILabel *label;
}

@property(nonatomic, strong)UIButton *imageBt;

@property(nonatomic, strong)UILabel *label;

@end
