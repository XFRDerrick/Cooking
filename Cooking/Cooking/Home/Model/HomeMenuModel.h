//
//  HomeMenuModel.h
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeMenuLinksModel;
@interface HomeMenuModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<HomeMenuLinksModel *> *links;
@property (nonatomic, copy) NSString *slug;

@end

@interface HomeMenuLinksModel : NSObject
/*
 "text":"川菜",
 "href":"/article/list_by_tag/川菜.json?order=title",
 "thumb":"/media/link_thumb/%E5%B7%9D%E8%8F%9C_uPozzyu.jpg"
 */
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *thumb;


@end
