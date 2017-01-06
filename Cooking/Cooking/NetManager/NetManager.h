//
//  NetManager.h
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "BaseNetManager.h"

//菜系种类
typedef enum{
    
    CookingStyleYueCai,
    CookingStyleChuanCai,
    CookingStyleSuCai,
    CookingStyleZheCai,
    CookingStyleMinCai,
    CookingStyleHuiCai,
    CookingStyleLuCai,
    CookingStyleShangHaiCai,
    CookingStyleDongBeiCai,
    CookingStyleHongBei,
    
}CookingStyle;

@interface NetManager : BaseNetManager

//+ (id)getUserInfoWithParamaters:(NSDictionary *)paramaters CompletionHandler:(void (^)(UNUserInfo *, NSError *))completionHandler

@end
