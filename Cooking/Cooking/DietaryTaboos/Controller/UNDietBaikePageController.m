//
//  UNDietBaikePageController.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietBaikePageController.h"
#import "UNDietBaikeListController.h"
@interface UNDietBaikePageController ()

@end

@implementation UNDietBaikePageController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.title = @"Hollow";
        self.menuViewStyle = WMMenuViewStyleFloodHollow;
        self.titleSizeSelected = 15;
        
//        self.menuBGColor = [UIColor whiteColor];
//        self.menuHeight = 35;
//        self.menuViewStyle = WMMenuViewStyleLine;
//        self.menuBGColor = [UIColor whiteColor];
        self.titleColorSelected = kRGBA_COLOR(95, 168, 252, 1);
        self.itemMargin = 10;
        //预加载无限制
        self.preloadPolicy =WMPageControllerCachePolicyNoLimit;
 
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}

#pragma mark 为MenuView添加右侧选择按钮
- (void)setupUI{

//    UIButton *button ms_xiala@2x
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width - 50, 0, 50, 20)];
    redView.backgroundColor = [UIColor redColor];
//    self.scrollView.maskView
    self.menuView.rightView = redView;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pageData

- (NSArray<NSString *> *)titles{
    return @[@"健康饮食",@"饮食禁忌",@"饮食误区",@"营养饮食",@"宝宝饮食",@"孕期饮食",@"病人饮食",@"老人饮食",@"春季饮食",@"夏季饮食",@"秋季饮食",@"冬季饮食",@"男性饮食",@"女性饮食",@"品茶禁忌"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
    
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    UNDietBaikeListController *pageVC = [[UNDietBaikeListController alloc] initWithStyle:UITableViewStylePlain withTitle:self.titles[index]];
    pageVC.title = self.titles[index];

    return pageVC;
    
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
