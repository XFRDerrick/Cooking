//
//  UITextField+FormatJudge.h
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (FormatJudge)

- (NSString *)deleteBlankSpace;
- (BOOL)isNULL;
- (BOOL)isTelephoneNum;

@end
