//
//  YaRegister.h
//  YayawanIOS
//
//  Created by akzhang on 14-2-27.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol qqLoginPositionDelegate <NSObject>

-(void)setPasswdText:(NSInteger)position;
-(void)setCleanIndex:(NSInteger)position;

@end

@interface DropListView : UIView<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *tv;//下拉列表
    
    NSArray *tableArray;//下拉列表数据
    
    UIButton *textBtn;//显示图片
    
    UITextField *textField;//显示文字
    
    BOOL showList;//是否弹出下拉列表
    
    CGFloat tabheight;//table下拉列表的高度
    
    CGFloat frameHeight;//frame的高度
    
    NSInteger position;
    
    id<qqLoginPositionDelegate> positionDelegate;
    
}


@property (nonatomic,retain) UITableView *tv;

@property (nonatomic,retain) NSArray *tableArray;

@property (nonatomic,retain) UIButton *textBtn;

@property (nonatomic,retain) UITextField *textField;

@property (nonatomic, retain)id<qqLoginPositionDelegate> positionDelegate;

//-(NSInteger)getPosition;

@end
