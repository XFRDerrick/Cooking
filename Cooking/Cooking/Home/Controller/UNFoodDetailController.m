//
//  UNFoodDetailController.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNFoodDetailController.h"

@interface UNFoodDetailController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation UNFoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
    
}

- (void)setupWebView{
    
    self.webView.scrollView.bounces = NO;
    NSString *path = [NSString stringWithFormat:kHomeFoodBasePath,self.resultId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 显示隐藏Tabbar

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
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
