//
//  UNEditUserNameController.h
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackValueBlock)(NSString *);

@interface UNEditUserNameController : UIViewController

@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) BackValueBlock backValueBlock;

@end
