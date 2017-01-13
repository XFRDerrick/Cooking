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
/**bmob id**/
#define kApplicationID @"1cb7173491f65ea3725d94f8086f16ae"


//界面一
//菜系
#define kCookingStyleBasePathHeader @"http://www.idwoo.net/api/"
#define kCookingStyleBasePathFoot @"/get_recent_posts/&page=0&dev=1"
//新的数据源
#define kHomeBasePath @"http://cookbook-cn.appcookies.com/article/link_container/com.appcookies.CookBook.json"
#define kHomeListBasePath @"http://cookbook-cn.appcookies.com" 
#define kHomeFoodBasePath @"http://cookbook-cn.appcookies.com/article/show/%@.html"



//界面二
//ii
#define kBasePath @"http://api.daydaycook.com.cn"
//JSON
#define kDayDayCookPath @"http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do"
//进入详情页Web id (请求的ID)
#define kCookMenu @"http://api.daydaycook.com.cn/daydaycook/h5/recipe/loadContent.do?id=%ld&languageId=&mainland="
//视频为请求的URL



//界面三
//减肥食谱 使用Post请求
#define KDietMenuPath @"http://zaijiawan.com/matrix_common/api/recipe/mainbook"

#define KDietListBasePath  @"http://zaijiawan.com/matrix_common/api/recipe/detailsbook"


//http://zaijiawan.com/matrix_common/api/recipe/detailsbook?appname=tianjianfeishipu&mainId=4&page=1

//界面四
//饮食禁忌
#define KDietaryPath @"http://www.idwoo.net/api/yinshiyiji/get_category_posts/"

#define KDietaryDetailPath @"http://www.idwoo.net/api/yinshiyiji/get_post/?post_id=841"
//新的data
#define kDietBaikeBasePath @"http://carapi.hbook.us/app/infolist"
#define kDietBaikeDetailBasePath @"http://carapi.hbook.us/Information.html"


#endif /* Constant_h */
