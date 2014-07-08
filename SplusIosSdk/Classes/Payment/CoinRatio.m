//
//  CoinRatio.m
//  SplusFramework
//
//  Created by akzhang on 14-6-30.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import "CoinRatio.h"

@implementation CoinRatio

+ (CoinRatio *)sharedSingleton
{
    static CoinRatio *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[CoinRatio alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}

-(void)initWithType:(NSString*)mCoinName Ratio:(int)mRatio
{
    _coinName = mCoinName;
    _ratio = mRatio;
}

@end
