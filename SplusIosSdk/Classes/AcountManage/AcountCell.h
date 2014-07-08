//
//  AcountCell.h
//  SplusFramework
//
//  Created by akzhang on 14-7-7.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcountCell : UITableViewCell

@property(nonatomic, strong)UIImageView *headImage;

@property(nonatomic, strong)UILabel *labelText;

@property(nonatomic, strong)UIImageView *tailImage;

@property(nonatomic, assign)UIInterfaceOrientation orientation;

@end
