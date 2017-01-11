//
//  UNDietViewController.m
//  Cooking
//
//  Created by universe on 2017/1/8.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "UNDietCollectionViewCell.h"
#import "UNChoiceMenuView.h"

#import "UNDietDetailViewController.h"

@interface UNDietViewController ()<CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSArray *menuDatas;
@property (nonatomic, strong) UNDietMenuDataModel *menuModel;

@property (nonatomic, strong) NSMutableArray *listDatas;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UNChoiceMenuView *choiceView;
@property (nonatomic, assign,getter=isCvShow) BOOL cvShow;

//手势
@property (nonatomic, assign) CGPoint firstPoint;

@end

@implementation UNDietViewController

#pragma mark - 懒加载
- (NSArray *)menuDatas{

    if (!_menuDatas) {
        _menuDatas = [NSArray array];
    }
    return _menuDatas;
}

- (NSMutableArray *)listDatas{

    if (!_listDatas) {
        _listDatas = [NSMutableArray array];
    }
    return _listDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.cvShow = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMenuView];
    [self setupNavItem];
    if (self.menuDatas.count == 0) {
        [self loadMenuDatas];
    }
    [self setupCollectionViewUI];
   
}

#pragma mark - 点击导航栏 分类
- (void)setupNavItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(choiceMenuAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)choiceMenuAction:(UIBarButtonItem *)item{
    //显示 消失VIew
    if (!self.isCvShow) {//需要显示
        [self showMenu];
    }else{//隐藏
        [self hidenMenu];
    }
}

#pragma mark - 侧栏的显示和消失
- (void)showMenu{
    self.cvShow = YES;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.choiceView.frame;
        frame.origin.x = 0;
        self.choiceView.frame = frame;
    }];
    
}

- (void)hidenMenu{
    self.cvShow = NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.choiceView.frame;
        frame.origin.x = -frame.size.width;
        self.choiceView.frame = frame;
    }];
    
}

#pragma mark -  MenuView的添加和点击动作

- (void)setupMenuView{

    UNChoiceMenuView *view = [[NSBundle  mainBundle] loadNibNamed:@"UNChoiceMenuView" owner:nil options:nil].lastObject;
    CGFloat w = kScreenSize.width / 3.0;
    CGFloat h = kScreenSize.height - 64- 44;
    view.frame = CGRectMake(-w, 64, w, h);
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    //设置监听mainId的变化
    __weak typeof(self) weakSelf = self;
    view.buttonBackBlock = ^void(NSInteger tag){
       
        [weakSelf hidenMenu];
        weakSelf.menuModel = weakSelf.menuDatas[tag];
        weakSelf.navigationItem.title = weakSelf.menuModel.title;
        [weakSelf.collectionView.mj_header beginRefreshing];
    };
    self.choiceView = view;
}


#pragma mark -  界面初始化 数据加载
- (NSArray *)getMenuSubViews{

    NSArray *arr = [NSArray array];
    arr = [self.choiceView subviews];
    return arr;
}

- (void)loadMenuDatas{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NetManager getDietMenuModelCompletionHandler:^(UNDietMenuModel *model, NSError *error) {
            if (!error) {
                NSLog(@"menu:%ld",model.data.count);
                self.menuDatas = model.data;
                self.menuModel = self.menuDatas[0];
                self.navigationItem.title = self.menuModel.title;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //加载menu后加载控制器
                    [self.collectionView.mj_header beginRefreshing];
                });
            }
        }];
        
        
    });
}

- (void)setupCollectionViewUI{

     // Register cell classes
 
    [self.collectionView registerNib:[UINib nibWithNibName:@"UNDietCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"dietCell"];
 
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesPanAction:)];
    
    [self.view addGestureRecognizer:panGes];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
       
        [NetManager getDietListModelWithMainId:self.menuModel.mainId Page:1 CompletionHandler:^(UNDietListModel *model, NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            if (!error) {
                [self.listDatas removeAllObjects];
                [self.listDatas addObjectsFromArray:model.data.recipes];
                [self.collectionView reloadData];
            }
        }];
    }];
//    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [NetManager getDietListModelWithMainId:self.menuModel.mainId Page:++ self.page CompletionHandler:^(UNDietListModel *model, NSError *error) {
            if (!error) {
                if (model.data.recipes.count ==0) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                    [self.listDatas addObjectsFromArray:model.data.recipes];
                    [self.collectionView reloadData];
                }
            }else{
               [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }];

    }];
    
    
}
- (void)gesPanAction:(UIPanGestureRecognizer *)pangr{
    
    CGPoint point = [pangr locationInView:self.view];
    if (self.firstPoint.x) {
        
        if (point.x - self.firstPoint.x > 10) {//显示
            [self showMenu];
        }else{//消失
            [self hidenMenu];
        }
    }else{
        self.firstPoint = point;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.listDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UNDietCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dietCell" forIndexPath:indexPath];
    
    cell.recipesModel = self.listDatas[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    
     CGFloat w = (long)((kScreenSize.width - 10 * 3) / 2.0);
     CGFloat h = w + 63;
    
    
    if (indexPath.row % 2==0) {
       return CGSizeMake(w, h - 35);
    }else{
        
     return CGSizeMake(w, h);
    }
    
    
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UNDietDetailViewController *detailVC = [[UNDietDetailViewController alloc] init];
    detailVC.model = self.listDatas[indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
}

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

*/

@end
