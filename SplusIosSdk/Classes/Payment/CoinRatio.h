//
//  CoinRatio.h
//  SplusFramework
//
//  Created by akzhang on 14-6-30.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinRatio : NSObject

+ (CoinRatio *)sharedSingleton;

@property(nonatomic, strong)NSString *coinName;
@property(nonatomic, assign)int ratio;

-(void)initWithType:(NSString*)coinName Ratio:(int)ratio;

@end
