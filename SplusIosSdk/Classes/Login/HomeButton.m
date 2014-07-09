//
//  HomeButton.m
//  YayawanIOS
//
//  Created by akzhang on 14-4-12.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "HomeButton.h"

@implementation HomeButton
@synthesize imageBt,label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*3/4)];
        [self addSubview:imageBt];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*3/4, self.frame.size.width, self.frame.size.height/4)];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
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
