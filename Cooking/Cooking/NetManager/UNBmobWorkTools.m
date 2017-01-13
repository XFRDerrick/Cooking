//
//  UNBmobWorkTools.m
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNBmobWorkTools.h"

@implementation UNBmobWorkTools

+ (BOOL)userIsLogin{

    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {
        return YES;
    }else{
        //对象为空时，可打开用户注册界面
        return NO;
    }
}

@end
