//
//  UNWonderfulViewController.m
//  Cooking
//
//  Created by universe on 2017/1/7.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNWonderfulViewController.h"
#import "YXMenuModel.h"

#import "UNWonderMenuCell.h"

@interface UNWonderfulViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *menuDatas;



@end

@implementation UNWonderfulViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)menuDatas{
    if (!_menuDatas) {
        _menuDatas = [NSMutableArray array];
    }
    return _menuDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.currentPage = 0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
     // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"UNWonderMenuCell" bundle:nil] forCellWithReuseIdentifier:@"menuCell"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [NetManager getCookingMenuModelWithpage:0 CompletionHandler:^(YXMenuModel *model, NSError *error) {
           [self.collectionView.mj_header endRefreshing];
           if (!error) {
               [self.menuDatas removeAllObjects];
               [self.menuDatas addObjectsFromArray:model.data];
               [self.collectionView reloadData];
           }
       }];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [NetManager getCookingMenuModelWithpage:++self.currentPage CompletionHandler:^(YXMenuModel *model, NSError *error) {
           [self.collectionView.mj_footer endRefreshing];
           if (!error) {
               [self.menuDatas addObjectsFromArray:model.data];
               [self.collectionView reloadData];
           }
       }];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.menuDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
        UNWonderMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
        
        cell.model = self.menuDatas[indexPath.row];
        
        return cell;

}

#pragma mark - UIScrollViewDelegate 滚动方法


#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (collectionView.frame.origin.y == kScreenSize.height/2) {
        return CGSizeMake(kScreenSize.width, kScreenSize.height/4);
    }
    return CGSizeMake(kScreenSize.width, kScreenSize.height/2);
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    NSLog(@"%f",cell.frame.origin.y);
//    if (cell.frame.origin.y < kScreenSize.height) {
//        return CGSizeMake(kScreenSize.width, kScreenSize.height * 0.5);
//    }else{
//    
//        return CGSizeMake(kScreenSize.width, kScreenSize.height * 0.25);
//    }
//    return CGSizeMake(kScreenSize.width, kScreenSize.height/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    YXCookMenuViewController *cookMenuVC = [[YXCookMenuViewController alloc]initWithData:[self.menuVM dataForRow:indexPath.row]];
//    [self.navigationController pushViewController:cookMenuVC animated:YES];
}




/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
