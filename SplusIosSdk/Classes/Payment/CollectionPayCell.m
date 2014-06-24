//
//  CollectionPayCell.m
//  SplusFramework
//
//  Created by akzhang on 14-6-24.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "CollectionPayCell.h"

@implementation CollectionPayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cellButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_cellButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
