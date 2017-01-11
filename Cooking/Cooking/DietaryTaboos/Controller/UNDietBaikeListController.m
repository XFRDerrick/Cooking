//
//  UNDietBaikeListController.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietBaikeListController.h"
#import "UNDietBaikeCell.h"
#import "UnDietBaikeDetailWebController.h"

@interface UNDietBaikeListController ()

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger page;

@end

@implementation UNDietBaikeListController

- (NSMutableArray *)datas{
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (instancetype)initWithStyle:(UITableViewStyle)style withTitle:(NSString *)title{

    if (self = [super initWithStyle:style]) {
        self.titleName = title;
        self.page = 1;
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{

    [self.tableView registerNib:[UINib nibWithNibName:@"UNDietBaikeCell" bundle:nil] forCellReuseIdentifier:@"dietBaikeCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [NetManager getDietBaiKeModelWithPage:1 Classes:self.titleName CompletionHandler:^(UNDietBaiKeModel *model, NSError *error) {
           [self.tableView.mj_header endRefreshing];
           if (!error) {
               if (!model) {
                   [self.datas removeAllObjects];
               }
               [self.datas addObjectsFromArray:model.list];
               [self.tableView reloadData];

           }
       }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [NetManager getDietBaiKeModelWithPage: ++self.page Classes:self.titleName CompletionHandler:^(UNDietBaiKeModel *model, NSError *error) {
           if (!error) {
               if (model.list.count ==0) {
                   [self.tableView.mj_footer endRefreshingWithNoMoreData];
               }else{
                   [self.tableView.mj_footer endRefreshing];
                   [self.datas addObjectsFromArray:model.list];
                   [self.tableView reloadData];
               }
           }else{
               [self.tableView.mj_footer endRefreshingWithNoMoreData];
           }

           
       }];
    }];
    
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

    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UNDietBaikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dietBaikeCell" forIndexPath:indexPath];
    
    cell.model = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UnDietBaikeDetailWebController *detailVC = [[UnDietBaikeDetailWebController alloc] init];

    detailVC.model = self.datas[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
