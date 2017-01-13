//
//  UITextField+FormatJudge.m
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UITextField+FormatJudge.h"

@implementation UITextField (FormatJudge)

- (NSString *)deleteBlankSpace{
    NSString *textName = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return textName;
}

- (BOOL)isNULL{

    if ([self deleteBlankSpace].length > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isTelephoneNum{

    NSString *mobiel = [self deleteBlankSpace];
    
    if (mobiel.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:mobiel];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobiel];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobiel];
        
        if (isMatch1 || isMatch2 || isMatch3) {//匹配
            return YES;
        }else{
            return NO;
        }
    }
    
}
@end
