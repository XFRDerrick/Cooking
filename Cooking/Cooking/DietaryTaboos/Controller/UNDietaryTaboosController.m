//
//  UNDietaryTaboosController.m
//  Cooking
//
//  Created by universe on 2017/1/8.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietaryTaboosController.h"
#import "YBPopupMenu.h"

#import "UNFoodCell.h"

#define TITLES @[@"饮食禁忌", @"饮食新知", @"饮食习惯",@"饮食误区", @"营养搭配", @"炒菜技巧"]

@interface UNDietaryTaboosController ()<YBPopupMenuDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<CookingStylePostsModel *> *datas;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger requID;

@end

@implementation UNDietaryTaboosController

- (NSMutableArray<CookingStylePostsModel *> *)datas{

    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTableView];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.requID = 334;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:@selector(addpopView:)];
}

- (void)setupTableView{
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"UNFoodCell" bundle:nil]     forCellReuseIdentifier:@"foodCell"];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [NetManager getDietaryModelWithPostId:self.requID Page:1 CompletionHandler:^(UNDietaryModel *model, NSError *error) {
            [self.tableView.mj_header endRefreshing];
            if (!error) {
                [self.datas removeAllObjects];
                [self.datas addObjectsFromArray:model.posts];
                [self.tableView reloadData];
            }
            
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        [NetManager getDietaryModelWithPostId:self.requID Page:++ self.page CompletionHandler:^(UNDietaryModel *model, NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            if (!error) {
                [self.datas addObjectsFromArray:model.posts];
                [self.tableView reloadData];
            }
        }];
        
    }];
    
    
}

#pragma mark - tableViewDataScourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UNFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell" forIndexPath:indexPath];
    cell.post = self.datas[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 88;
}



- (void)addpopView:(UIBarButtonItem *)sender{

    CGFloat x = 10;
    CGFloat y = 54;
    CGPoint p = CGPointMake(x, y);
    
    YBPopupMenu *popupMenu = [YBPopupMenu showAtPoint:p titles:TITLES icons:nil menuWidth:100 delegate:nil];
    popupMenu.dismissOnSelected = NO;
    popupMenu.isShowShadow = YES;
    popupMenu.delegate = self;
    popupMenu.offset = 10;
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
//    [ybPopupMenu setHidden:YES];
    self.title = TITLES[index];
    switch (index) {
        case 0:
            self.requID = 334;
            break;
        case 1:
            self.requID = 335;
            break;
        case 2:
            self.requID = 336;
            break;
        case 3:
            self.requID = 337;
            break;
        case 4:
            self.requID = 338;
            break;
        case 5:
            self.requID = 339;
            break;
        default:
            break;
    }
    //重新请求加载数据
    [self.tableView.mj_header beginRefreshing];
    
    
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
