//
//  UNHomeTableViewController.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNHomeTableViewController.h"

#import "UNCookingStyleCell.h"

@interface UNHomeTableViewController ()<UNCookingStyleCellDelegate,UICollectionViewDelegate>


@end

@implementation UNHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView{

    [self.tableView registerNib:[UINib nibWithNibName:@"UNCookingStyleCell" bundle:nil] forCellReuseIdentifier:@"cookingStyleCell"];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UNCookingStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cookingStyleCell" forIndexPath:indexPath];
    //设置选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.collectionView.delegate = self;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (long)((kScreenSize.width - 10 * 3) / 5.0 * 2);
    CGFloat h = w + 21 * 2 + 15 + 45 + 10;
    return h;
}

#pragma mark - 点击cell/button 事件
- (void)cookingStyleCell:(UNCookingStyleCell *)cell didClickShowAllButton:(UIButton *)sender{
    NSLog(@"显示全部菜单");
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%ld",indexPath.row);
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
