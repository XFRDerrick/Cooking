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
@property (nonatomic, strong) NSArray *foodStylesTitle;

@property (nonatomic, strong) NSMutableDictionary *stylesData;

@end

@implementation UNHomeTableViewController

- (NSMutableDictionary *)stylesData{

    if (!_stylesData) {
        _stylesData = [NSMutableDictionary dictionary];
    }
    return _stylesData;
}
- (NSArray *)foodStylesTitle{

    if (!_foodStylesTitle) {
        _foodStylesTitle = @[@"粤菜",@"川菜",@"苏菜",@"浙菜",@"闽菜",@"徽菜",@"鲁菜",@"上海菜",@"东北菜",@"烘焙"];
    }
    return _foodStylesTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    //异步加载数据
    [self loadCookingData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView{

    [self.tableView registerNib:[UINib nibWithNibName:@"UNCookingStyleCell" bundle:nil] forCellReuseIdentifier:@"cookingStyleCell"];
//    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//       
//        
//    }];
    
}

- (void)loadCookingData{
    
    for (int i =0; i < self.foodStylesTitle.count; i ++) {
        
        dispatch_async(dispatch_queue_create(0, 0), ^{

            [NetManager getCookingStyleModelWithStyle:i CompletionHandler:^(CookingStyleModel *model, NSError *error) {
                //请求
                [self.stylesData setObject:model forKey:@(i).stringValue];
//                NSLog(@"%ld",self.stylesData.count);
                //刷新指定行
                //[self.tableView reloadData];
                [self.tableView reloadRow:i inSection:0 withRowAnimation:UITableViewRowAnimationNone];
            }];
        });
        
    }

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
    if ([self.stylesData objectForKey:@(indexPath.row).stringValue]) {
        NSArray<CookingStylePostsModel *> *modelArr = [[self.stylesData objectForKey:@(indexPath.row).stringValue] posts];
      
        cell.posts = modelArr;
    }
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
