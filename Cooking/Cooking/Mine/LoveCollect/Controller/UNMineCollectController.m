//
//  UNMineCollectController.m
//  Cooking
//
//  Created by universe on 2017/1/12.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNMineCollectController.h"
#import "UNMineViewController.h"
#import "UNBaseNavController.h"
#import "UNLoginRegisterController.h"

#import "PlistWorkTools.h"
#import "UNHomeListCell.h"
#import "UNDietBaikeCell.h"
#import "UNNormalFoodCell.h"
#import "UNCollectionHeader.h"


@interface UNMineCollectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *noDataBackGroundIV;
@property (nonatomic, assign,getter=isLogin) BOOL login;

@property (nonatomic, strong) UNLoginRegisterController *lrVC;
@property (nonatomic, strong) UNCollectionModel *collectionData;
//显示shoucang
@property (nonatomic, strong) UITableView *tableView;
//展开按钮
@property (nonatomic, strong) NSMutableArray *showButtons;

@end

@implementation UNMineCollectController


- (NSMutableArray *)showButtons{

    if (!_showButtons) {
        _showButtons = [NSMutableArray array];
    }
    return _showButtons;
}
#pragma mark - 懒加载
- (UIImageView *)noDataBackGroundIV{

    if (!_noDataBackGroundIV) {
        _noDataBackGroundIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favEmpty"]];
        
        [self.view addSubview: _noDataBackGroundIV];
        [_noDataBackGroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(100);
            make.left.equalTo(self.view).offset(50);
            make.right.equalTo(self.view).offset(-50);
            make.height.mas_equalTo(200);
        }];
        
    }
    return _noDataBackGroundIV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //是否登录
    self.login = [UNBmobWorkTools userIsLogin];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self noDataBackGroundIV];
    if (self.isLogin) {//已经登录
        //获取文件，读取数据
        [self readCollectionFile];
        if (!self.collectionData.isCollectionNil) {
            //不为空加载
            [self.tableView reloadData];
        }else{
            //收藏为空 ，提示收藏
            [self.view bringSubviewToFront:self.noDataBackGroundIV];
            [self.view showMessage:@"您还没有任何收藏哦！"];
        }
        
    }else{//未登录 提示登录
        [self addAlterVC];
    }
}
- (void)readCollectionFile{
    
    NSString *pathN = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [pathN stringByAppendingString:@"/collection.plist"];
    
    NSLog(@"collectionPath: %@",path);
    //判断沙盒中文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {//存在
        self.collectionData = [PlistWorkTools readCollectionDatas];
        
    }else{
       
        //创建
        NSMutableArray<HomeListResultModel *> *cookingStyleData = [NSMutableArray array];
        NSMutableArray<MenuDataModel *> *recommendData = [NSMutableArray array];
        NSMutableArray<UNDietListDataRecipesModel *> *dietData = [NSMutableArray array];
        NSMutableArray<UNDietBaiKeListModel *> *healthyDietData = [NSMutableArray array];

        NSMutableDictionary *collections = [NSMutableDictionary dictionary];
        [collections setObject:cookingStyleData forKey:@"CookingStyle"];
        [collections setObject:recommendData forKey:@"Recommend"];
        [collections setObject:dietData forKey:@"Diet"];
        [collections setObject:healthyDietData forKey:@"HealthyDiet"];
       
       //创建student对象
        if ([collections writeToFile:path atomically:YES]) {
            NSLog(@"文件创建成功！！");
        }else{
            NSLog(@"文件创建失败");
        }
        
        self.collectionData = [[UNCollectionModel alloc] init];
    }
    
    
}
#pragma mark 收藏展示

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-44);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"UNHomeListCell" bundle:nil] forCellReuseIdentifier:@"homeListCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"UNNormalFoodCell" bundle:nil] forCellReuseIdentifier:@"foodNormalCell"];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"UNDietBaikeCell" bundle:nil] forCellReuseIdentifier:@"dietBaikeCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"UNCollectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"collectionHeader"];
        
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //获取头按钮
    UIButton *rowBtn = nil;
    for (UIButton *btn in self.showButtons) {
        if (btn.tag == section) {
            rowBtn = btn;
        }
    }
    
    NSUInteger count = 0;
    switch (section) {
        case 0:
            if (rowBtn) {
                count = self.collectionData.cookingStyleData.count;
            }
            break;
        case 1:
            if (rowBtn) {
                count = self.collectionData.recommendData.count;
            }
            break;
        case 2:
            if (rowBtn) {
                count = self.collectionData.dietData.count;
            }
            break;
        case 3:
            if (rowBtn) {
                count = self.collectionData.healthyDietData.count;
            }
            break;
        default:
            break;
    }
 
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        UNHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeListCell" forIndexPath:indexPath];
        cell.model = self.collectionData.cookingStyleData[indexPath.row];
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        
        UNNormalFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodNormalCell" forIndexPath:indexPath];
        
        cell.titleLable.text = @"haha";
        
        return cell;

    }else{
        UNDietBaikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dietBaikeCell" forIndexPath:indexPath];
        
        cell.model = self.collectionData.healthyDietData[indexPath.row];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UNCollectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"collectionHeader"];
    headerView.contentView.backgroundColor = kRGBA_COLOR(244, 244, 234, 1);
    headerView.rowButton.tag = section;
    if (section == 0) {
        headerView.titleLable.text = @"菜系收藏";
        headerView.collectionsCountLable.text = @(self.collectionData.cookingStyleData.count).stringValue;
    }else if (section == 1){
        headerView.titleLable.text = @"推荐收藏";
        headerView.collectionsCountLable.text = @(self.collectionData.recommendData.count).stringValue;
    }else if (section == 2){
        headerView.titleLable.text = @"减肥收藏";
        headerView.collectionsCountLable.text = @(self.collectionData.dietData.count).stringValue;
    }else{
        headerView.titleLable.text = @"健康饮食收藏";
        headerView.collectionsCountLable.text = @(self.collectionData.healthyDietData.count).stringValue;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        NSLog(@"点击了：%ld",section);
        headerView.rowButton.selected = !headerView.rowButton.selected;
        if (headerView.rowButton.selected) {
            [self.showButtons addObject:headerView.rowButton];
        }else{
            [self.showButtons removeObject:headerView.rowButton];
        }
        [self.tableView reloadData];
    }];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
    
}




#pragma mark 登录提示
- (void)addAlterVC{
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，请先登录！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消登录" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //跳转到登录界面
         UNLoginRegisterController *loginVC = [[UNLoginRegisterController alloc] init];
        
        loginVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismisLoginRegisterVC:)];
        
        self.lrVC = loginVC;
        [self  presentViewController:[[UNBaseNavController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
        
    }];
    
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionDone];
    
    [self presentViewController:alterVC animated:YES completion:nil];
}

- (void)dismisLoginRegisterVC:(UIBarButtonItem *)sender{

    [self.lrVC dismissViewControllerAnimated:YES completion:nil];
    //解除引用
    self.lrVC = nil;
}

#pragma mark 导航栏设置

- (void)setupNav{

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fav_nd_icon_36"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfoLogin:)];
}

- (void)userInfoLogin:(UIBarButtonItem *)item{

    UNMineViewController *mineVC = [[UNMineViewController alloc] init];
    
    [self presentViewController:[[UNBaseNavController alloc] initWithRootViewController:mineVC] animated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    self.login = [UNBmobWorkTools userIsLogin];
    if (self.isLogin) {
        
        [self readCollectionFile];
        if (!self.collectionData.isCollectionNil) {
            
            [self.view bringSubviewToFront:self.tableView];
            [self.tableView reloadData];
        }else{
            [self.view bringSubviewToFront:self.noDataBackGroundIV];
        }
    }else{
         [self.view bringSubviewToFront:self.noDataBackGroundIV];
    }
    
    
}


@end
