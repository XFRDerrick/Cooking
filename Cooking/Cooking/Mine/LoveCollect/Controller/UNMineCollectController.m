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
@interface UNMineCollectController ()

@property (nonatomic, strong) UIImageView *noDataBackGroundIV;
@property (nonatomic, assign,getter=isLogin) BOOL login;

@end

@implementation UNMineCollectController

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
    self.login = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    
    if (self.isLogin) {//已经登录
        //如果收藏为空显示
        [self noDataBackGroundIV];
        
        //不为空加载
 
    }else{//未登录
        //提示登录
        [self noDataBackGroundIV];
        [self addAlterVC];
    }
    
    
}

- (void)addAlterVC{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，请先登录！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消登录" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //跳转到登录界面
        [self userInfoLogin:nil];
    }];
    
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionDone];
    
    [self presentViewController:alterVC animated:YES completion:nil];
}


- (void)setupNav{

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fav_nd_icon_36"] style:UIBarButtonItemStyleDone target:self action:@selector(userInfoLogin:)];
}

- (void)userInfoLogin:(UIBarButtonItem *)item{

    UNMineViewController *mineVC = [[UNMineViewController alloc] init];
    
    [self presentViewController:[[UNBaseNavController alloc] initWithRootViewController:mineVC] animated:YES completion:nil];
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
