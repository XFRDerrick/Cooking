//
//  UNHomeMenuListController.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNHomeMenuListController.h"
#import "UNMenuListCell.h"
#import "UNAllFoodsListController.h"

@interface UNHomeMenuListController ()

@end

@implementation UNHomeMenuListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    
}

- (void)setupNav{

    self.title = @"菜品";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"bt_listen-knowledge_share_button_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];

}
- (void)backAction:(UIBarButtonItem *)item{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupTableView{

    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"UNMenuListCell" bundle:nil] forCellReuseIdentifier:@"menuListCell"];
    
    [self.tableView scrollToRow:(NSUInteger)self.index inSection:0 atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menuData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNMenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuListCell" forIndexPath:indexPath];
    cell.model = self.menuData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UNAllFoodsListController *listVC = [[UNAllFoodsListController alloc] initWithStyle:UITableViewStylePlain WithModel:self.menuData[indexPath.row]];
    
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
