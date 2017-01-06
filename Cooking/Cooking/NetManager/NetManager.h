//
//  NetManager.h
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "BaseNetManager.h"

#import "CookingStyleModel.h"

//菜系种类
typedef enum{
    CookingStyleYueCai = 0,
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

+ (id)getCookingStyleModelWithStyle:(CookingStyle)style CompletionHandler:(void (^)(CookingStyleModel *model, NSError *error))completionHandler;

@end
