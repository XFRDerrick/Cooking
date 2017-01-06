//
//  BaseNetManager.m
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "BaseNetManager.h"

@implementation BaseNetManager

+ (id)GET:(NSString *)path paramaters:(NSDictionary *)paramaters completionHandler:(void (^)(id, NSError *))completionHandler{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBasePath]];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    return [manager GET:path parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",task.currentRequest.URL.absoluteString);
        
        !completionHandler ?:completionHandler(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task.currentRequest.URL.absoluteString);
        NSLog(@"%@",error);
        !completionHandler ?:completionHandler(nil,error);
        
    }];
}
+ (id)POST:(NSString *)path paramaters:(NSDictionary *)paramaters completionHandler:(void (^)(id, NSError *))completionHandler{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    
    return [manager GET:path parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success_%@",task.currentRequest.URL.absoluteString);
        
        NSLog(@"status__%@",responseObject[@"status"]);
        !completionHandler ?:completionHandler(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure_%@",task.currentRequest.URL.absoluteString);
        NSLog(@"error_%@",error);
        !completionHandler ?:completionHandler(nil,error);
        
    }];
    
}


@end
