//
//  UNAllFoodsListController.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNAllFoodsListController.h"
#import "UNFoodCell.h"
@interface UNAllFoodsListController ()

@property (nonatomic, assign) CookingStyle style;
@property (nonatomic, strong) NSArray *allDatas;

@property (nonatomic, assign) NSInteger currentPage;



@end

@implementation UNAllFoodsListController

//初始化方法
- (instancetype)initWithStyle:(UITableViewStyle)style withRow:(CookingStyle)cookStyle andDatas:(NSArray<CookingStylePostsModel *> *)allData{

    if (self = [super initWithStyle:style]) {
        self.style = cookStyle;
        self.allDatas = allData;
        self.currentPage = 1;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UNFoodCell" bundle:nil] forCellReuseIdentifier:@"foodCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       //下拉刷新 重新加载数据
        [NetManager getCookingStyleModelWithStyle:self.style CompletionHandler:^(CookingStyleModel *model, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            if (!error) {
                self.allDatas = model.posts;
                self.currentPage = 1;
                [self.tableView reloadData];
            }
        }];
    }];
    if (!self.allDatas) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       //根据显示的数据
         self.currentPage += 1;
         [self.tableView reloadData];
     
         [self.tableView.mj_footer endRefreshing];
        if (self.currentPage * 15 >= self.allDatas.count) {
            [self centerShowMessage:@"已经没有数据了"];
        }
        
    }];
}

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
    return [self getShowPageDatas:self.currentPage];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell" forIndexPath:indexPath];
    
    cell.post = self.allDatas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 88;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
