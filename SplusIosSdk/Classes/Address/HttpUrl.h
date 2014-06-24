//
//  HttpUrl.h
//  SplusIosSdk
//
//  Created by akzhang on 14-6-16.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#ifndef SplusIosSdk_HttpUrl_h
#define SplusIosSdk_HttpUrl_h

//获取屏幕分辨率
#define SCREENHEIGHT [GetImage screenSize].height
#define SCREENWIDTH [GetImage screenSize].width

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//激活URL
static const NSString *API_URL_ACTIVATE = @"http://api.splusgame.com/sdk/active.php";
static const NSString *API_URL_LOGIN = @"http://api.splusgame.com/sdk/login.php";
static const NSString *API_URL_REGISTER = @"http://api.splusgame.com/sdk/reg.php";


//http://api.splusgame.com/sdk/reg.php?referer=Splus&partner=1&passport=e324eb6209c54fd5fafb4f992733d923&gameid=1000001&fastreg=1&password=fbbbbbbbbbbb&debug=1&sign=3895c64d1742ec434c5b1799909783a5&time=1403510927&deviceno=99885041d422233b8aa12fb63f7e4d23
#endif
