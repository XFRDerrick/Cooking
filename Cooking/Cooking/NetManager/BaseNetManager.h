//
//  BaseNetManager.h
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject

+ (id)GET:(NSString *)path paramaters:(NSDictionary *)paramaters completionHandler:(void(^)(id respondObj,NSError *error))completionHandler;

+ (id)POST:(NSString *)path paramaters:(NSDictionary *)paramaters completionHandler:(void(^)(id respondObj,NSError *error))completionHandler;

@end
