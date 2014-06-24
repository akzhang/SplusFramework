//
//  DropCell.m
//  YayawanIOS
//
//  Created by akzhang on 14-3-8.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "DropCell.h"
#import "GetImage.h"

@implementation DropCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:_deleteButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
