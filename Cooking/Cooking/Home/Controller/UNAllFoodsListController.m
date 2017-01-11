//
//  UNAllFoodsListController.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNAllFoodsListController.h"
#import "UNHomeListCell.h"
#import "UNFoodDetailController.h"

@interface UNAllFoodsListController ()
//请求数据
@property (nonatomic, strong) HomeMenuLinksModel *model;

@property (nonatomic, assign) CookingStyle style;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) HomeListPagingModel *nextRequest;

@property (nonatomic, assign) NSInteger currentPage;



@end

@implementation UNAllFoodsListController


- (NSMutableArray *)allDatas{
    
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}

//初始化方法
- (instancetype)initWithStyle:(UITableViewStyle)style WithModel:(HomeMenuLinksModel *)model{

    if (self = [super initWithStyle:style]) {
        self.model = model;
        self.title = model.text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UNHomeListCell" bundle:nil] forCellReuseIdentifier:@"homeListCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       //下拉刷新 重新加载数据
        [NetManager getHomeListModelWithLinkshref:self.model.href CompletionHandler:^(HomeListModel *model, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            if (!error) {
                self.nextRequest = model.paging;
                [self.allDatas removeAllObjects];
                [self.allDatas addObjectsFromArray:model.result];
                [self.tableView reloadData];
            }
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       //根据显示的数据
        [NetManager getHomeListModelWithLinkshref:self.nextRequest.next CompletionHandler:^(HomeListModel *model, NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            if (!error) {
                self.nextRequest = model.paging;
                [self.allDatas addObjectsFromArray:model.result];
                [self.tableView reloadData];
            }
        }];
    }];
}

#pragma mark - HUD

- (void)centerShowMessage:(NSString *)message{
    [self.view hidenHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.centerY = self.tableView.contentOffset.y;
//    hud.yOffset = self.tableView.contentOffset.y;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:1.0];
    
    
    
}

- (NSInteger)getShowPageDatas:(NSInteger)currentPage{
    
    NSInteger totalPage = self.allDatas.count % 15 == 0 ? self.allDatas.count / 15 : self.allDatas.count / 15 + 1;
    NSLog(@"%ld",totalPage);
    if (currentPage < totalPage) {
        if (currentPage == totalPage - 1) {
            return self.allDatas.count;
        }else{
            return self.currentPage * 15;
        }
    }
     return self.allDatas.count;;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeListCell" forIndexPath:indexPath];
    cell.model = self.allDatas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeListResultModel *model = self.allDatas[indexPath.row];
    UNFoodDetailController *detailVC = [[UNFoodDetailController alloc] init];
    detailVC.resultId = model.resultId;
    detailVC.title = model.title;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 显示隐藏Tabbar

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;
}



@end
