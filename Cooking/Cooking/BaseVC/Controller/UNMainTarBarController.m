//
//  UNMainTarBarController.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNMainTarBarController.h"


#import "UNBaseNavController.h"
#import "UNHomeTableViewController.h"
#import "UNWonderfulViewController.h"
#import "UNWonderMenuLayout.h"

#import "UNMineViewController.h"
#import "UNMineCollectController.h"
#import "UNDietViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

#import "UNDietaryTaboosController.h"
#import "UNDietBaikePageController.h"

@interface UNMainTarBarController ()

@end

@implementation UNMainTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self addChildControllers];
    
}
- (void)setupUI{
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = kRGBA_COLOR(237, 109, 0, 1);
    
}

- (void)addChildControllers{

    UNHomeTableViewController *homeVC = [[UNHomeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    homeVC.title = @"菜品分类";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"item-zf"];
     [self addChildViewController:[[UNBaseNavController alloc] initWithRootViewController:homeVC]];
    
    UNWonderfulViewController *wonVC = [[UNWonderfulViewController alloc] initWithCollectionViewLayout:[[UNWonderMenuLayout alloc] init]];
    wonVC.title = @"菜谱推荐";
    wonVC.tabBarItem.image = [UIImage imageNamed:@"item-fl"];
     [self addChildViewController:[[UNBaseNavController alloc] initWithRootViewController:wonVC]];
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    UNDietViewController *dietVC = [[UNDietViewController alloc] initWithCollectionViewLayout:layout];
    dietVC.title = @"减肥食谱";
    dietVC.tabBarItem.image = [UIImage imageNamed:@"item-home"];
      [self addChildViewController:[[UNBaseNavController alloc] initWithRootViewController:dietVC]];
  
    UNDietBaikePageController *baikeVC = [[UNDietBaikePageController alloc] init];
    baikeVC.title = @"健康饮食";
    baikeVC.tabBarItem.image = [UIImage imageNamed:@"item-gx"];
    [self addChildViewController:[[UNBaseNavController alloc] initWithRootViewController:baikeVC]];
    
    UNMineCollectController *mineVC = [[UNMineCollectController alloc] init];
    mineVC.title = @"我的收藏";
    mineVC.tabBarItem.image = [UIImage imageNamed:@"item-fav"];
    [self addChildViewController:[[UNBaseNavController alloc] initWithRootViewController:mineVC]];
    
   
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
