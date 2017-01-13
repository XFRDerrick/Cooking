//
//  UNMineViewController.m
//  PublicNews
//
//  Created by universe on 2016/12/9.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNMineViewController.h"
#import "UNMineCell.h"
#import "UNMineLoginHeaderCell.h"

//关于我们
#import "UNLoginRegisterController.h"

#import "UNAboutController.h"
#import "UNSetTableViewController.h"


//#import "UNWeiBoLoginController.h"
#import "UNUserInfo.h"

@interface UNMineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UNUserInfo *userInfoModel;

@end

@implementation UNMineViewController

- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenSize.height * 0.4, kScreenSize.width, kScreenSize.height * 0.4) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        _tableView.rowHeight = 50;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

- (UICollectionView *)collectionView{

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CGFloat width = (long)((kScreenSize.width - 20 * 2 - 10 * 3) / 4);
        CGFloat height = width + 44;
        layout.itemSize = CGSizeMake(width, height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height * 0.4) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"UNMineCell" bundle:nil] forCellWithReuseIdentifier:@"UNMineCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"UNMineLoginHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"UNMineLoginHeaderCell"];
    }

    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.collectionView;
    [self setupNav];
   
    //判断是否登录
    [self changeLoginAndGetUserInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginAndGetUserInfo) name:@"isLogin" object:nil];
    
}


- (void)setupNav{
    self.navigationItem.title = @"我";
    UIBarButtonItem *but = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IQButtonBarArrowLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = but;
}

- (void)backAction:(UIBarButtonItem *)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        UNMineLoginHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UNMineLoginHeaderCell" forIndexPath:indexPath];
       
        return cell;
    }else{
    
        UNMineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UNMineCell" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                cell.title = @"收藏同步";
                break;
            case 1:
                cell.title = @"意见反馈";
                break;
            case 2:
                cell.title = @"其他";
                break;
            default:
                break;
        }
        
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
       
        //如果没有登录—— 登录界面
        UNLoginRegisterController *loginVC = [[UNLoginRegisterController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];

        
    }else{
        if (indexPath.row == 0) {
            __weak typeof(self) weekSelf = self;
            [self addAlterVCWithTitle:@"确认同步" message:@"您收藏的菜谱会同步到登录账号，建议同步！" handler:^{
                [weekSelf.view showMessage:@"同步成功"];
            }];
        }else if (indexPath.row == 1){
            
            UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"反馈" message:@"有问题请联系：hetengfei163@126.com" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alterVC addAction:actionDone];
            [self presentViewController:alterVC animated:YES completion:nil];
        }else if (indexPath.row == 2){
            [self.view showMessage:@"敬请期待"];
        }
        
    }
    
}


- (void)addAlterVCWithTitle:(nullable NSString *)title message:(nullable NSString *)message handler:(void (^)())comHandler{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        comHandler();
    }];
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionDone];
    
    [self presentViewController:alterVC animated:YES completion:nil];
}



#pragma mark - UICollectionViewDelegateflowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenSize.width, collectionView.bounds.size.height * 2 / 3);
    }else{
        
        CGFloat width = (long)((kScreenSize.width - 50 * 2 - 10 * 2) / 3);
        CGFloat height = collectionView.bounds.size.height / 3;
        return CGSizeMake(width, height);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if (section == 1) {
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return UIEdgeInsetsZero;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    UIImage *tableViewImage = nil;
    NSString *titleStr = nil;
    switch (indexPath.row) {
        case 0:
            tableViewImage = [UIImage imageNamed:@"ic_common_goldenmusic_normal"];
            titleStr = @"推送";
            break;
        case 1:
            tableViewImage = [UIImage imageNamed:@"ic_common_goldenmusic_normal"];
            titleStr = @"清除缓存";
            break;
        case 2:
            tableViewImage = [UIImage imageNamed:@"ic_common_goldenmusic_normal"];
            titleStr = @"设置";
            break;
        case 3:
            tableViewImage = [UIImage imageNamed:@"ic_common_goldenmusic_normal"];
            titleStr = @"关于我们";
            break;
        default:
            break;
    }
    
    cell.imageView.image = tableViewImage;
    cell.textLabel.text = titleStr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weekSelf = self;
    if (indexPath.row == 1) {
        
        [self addAlterVCWithTitle:@"提示" message:@"是否清空缓存" handler:^{
            [weekSelf.view showMessage:@"缓存已清除!"];
        }];
        
    }else if(indexPath.row == 2){
    
        UNSetTableViewController *setVC = [[UNSetTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if (indexPath.row == 3){
    
        UNAboutController *aboutVC = [[UNAboutController alloc] init];
        aboutVC.title = @"关于";
        [self.navigationController pushViewController:aboutVC animated:YES];
        
    
    }else{
        
        [self.view showMessage:@"敬请期待"];
    }
    
}

- (void)changeLoginAndGetUserInfo{
    
}

- (void)viewWillAppear:(BOOL)animated{
    //登录刷新
}
- (void)viewWillDisappear:(BOOL)animated{
}

@end
