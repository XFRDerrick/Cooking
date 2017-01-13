//
//  UNHomeTableViewController.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNHomeTableViewController.h"

#import "UNCookingStyleCell.h"
#import "UNHomeCollectionViewCell.h"
#import "UNHomeMenuListController.h"

#import "UNAllFoodsListController.h"
#import "UNFoodDetailController.h"

#import "UNBaseNavController.h"

@interface UNHomeTableViewController ()<UNCookingStyleCellDelegate,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray<HomeMenuLinksModel *> *menuDatas;
@property (nonatomic, strong) NSArray *foodStylesTitle;
@property (nonatomic, strong) NSMutableArray *menuCategoryDatas;

@property (nonatomic, strong) NSMutableDictionary *stylesData;

@end

@implementation UNHomeTableViewController

- (NSArray<HomeMenuLinksModel *> *)menuDatas{

    if (!_menuDatas) {
        _menuDatas = [NSArray array];
    }
    return _menuDatas;
}
- (NSMutableArray *)menuCategoryDatas{
    
    if (!_menuCategoryDatas) {
        _menuCategoryDatas = [NSMutableArray array];
    }
    return _menuCategoryDatas;
}
- (NSMutableDictionary *)stylesData{

    if (!_stylesData) {
        _stylesData = [NSMutableDictionary dictionary];
    }
    return _stylesData;
}
- (NSArray *)foodStylesTitle{

    if (!_foodStylesTitle) {
        _foodStylesTitle = @[@"地方菜",@"家常",@"中西点心",@"食材",@"菜品/厨具",@"人群",@"其他"];
    }
    return _foodStylesTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    //异步加载数据
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView{

    [self.tableView registerNib:[UINib nibWithNibName:@"UNCookingStyleCell" bundle:nil] forCellReuseIdentifier:@"cookingStyleCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NetManager getHomeMenuModelCompletionHandler:^(HomeMenuModel *model, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            if (!error) {
                self.menuDatas = model.links;
                [self categoryMenuDatas];
                //刷新
                [self.tableView reloadData];
            }
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
}
//将数据分组存放
- (void)categoryMenuDatas{
    NSArray *arrOne = [self.menuDatas subarrayWithRange:NSMakeRange(0, 5)];
    NSArray *arrTwo = [self.menuDatas subarrayWithRange:NSMakeRange(5, 4)];
    NSArray *arrThree = [self.menuDatas subarrayWithRange:NSMakeRange(9, 7)];
    NSArray *arrFour = [self.menuDatas subarrayWithRange:NSMakeRange(16, 10)];
    NSArray *arrFive = [self.menuDatas subarrayWithRange:NSMakeRange(26,10)];
    NSArray *arrSix = [self.menuDatas subarrayWithRange:NSMakeRange(36, 3)];
    NSArray *arrSeven = [self.menuDatas subarrayWithRange:NSMakeRange(39, self.menuDatas.count - 39)];
    self.menuCategoryDatas = @[arrOne,arrTwo,arrThree,arrFour,arrFive,arrSix,arrSeven].mutableCopy;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodStylesTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UNCookingStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cookingStyleCell" forIndexPath:indexPath];
    //设置选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.collectionView.delegate = self;
    
    //数据传值
    cell.headerTitle = self.foodStylesTitle[indexPath.row];
    if (self.menuCategoryDatas.count > 0) {
        cell.links = self.menuCategoryDatas[indexPath.row];
    }
    cell.tag = indexPath.row;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (long)((kScreenSize.width - 10 * 3) / 5.0 * 2);
    CGFloat h = w + 30 + 44 + 10;
    return h;
}

#pragma mark - 点击cell/button 事件
- (void)cookingStyleCell:(UNCookingStyleCell *)cell didClickShowAllButton:(UIButton *)sender{
   
    int count = 0;
    for (int i = 0; i <= cell.tag; i ++) {
        count += [(NSMutableArray*)self.menuCategoryDatas[i] count];
    }
    
    UNHomeMenuListController *menuList = [[UNHomeMenuListController alloc] initWithStyle:UITableViewStylePlain];
    
    menuList.menuData = self.menuDatas;
    menuList.index = count-1;
    [self presentViewController:[[UNBaseNavController alloc] initWithRootViewController:menuList] animated:YES completion:nil];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UNHomeCollectionViewCell *cell = (UNHomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    HomeMenuLinksModel *model = cell.model;

    UNAllFoodsListController *listVC = [[UNAllFoodsListController alloc] initWithStyle:UITableViewStylePlain WithModel:model];
    
    [self.navigationController pushViewController:listVC animated:YES];
    
    
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
