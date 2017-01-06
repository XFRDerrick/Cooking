//
//  Constant.h
//  PublicNews
//
//  Created by universe on 2016/12/1.
//  Copyright © 2016年 universe. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
//屏幕Size
#define kSCREEN_SIZE [UIScreen mainScreen].bounds.size
//RGB颜色
#define kRGBA_COLOR(r,g,b,a) [UIColor colorWithRed:r/ 255.0 green:g/ 255.0 blue:b/ 255.0 alpha:a];

//菜系
#define kCookingStyleBasePathHeader @"http://www.idwoo.net/api/"
#define kCookingStyleBasePathFoot @"/get_recent_posts/&page=0&dev=1"

//
#define VideoPath @"http://www.yidianzixun.com/home?page=channel&id=u13746"

#define JokeBasePath @"http://japi.juhe.cn/joke/content/text.from"
#define JokePictureBasePath @"http://japi.juhe.cn/joke/img/text.from"


#endif /* Constant_h */
