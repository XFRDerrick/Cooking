//
//  UnDietBaikeDetailWebController.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UnDietBaikeDetailWebController.h"

@interface UnDietBaikeDetailWebController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

//收藏按钮
@property (nonatomic, strong) UIButton *like;
@end

@implementation UnDietBaikeDetailWebController


#pragma mark - 收藏按钮
- (UIButton *)like {
    if(!_like) {
        _like = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - 45 - 10, kScreenSize.height * 0.5, 45, 45)];
        [self.view addSubview:_like];
        _like.selected = NO;
        _like.layer.cornerRadius = 45/2.0;
        [_like setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_normal"] forState:UIControlStateNormal];
        [_like setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_press"] forState:UIControlStateHighlighted];
        [_like setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_hl"] forState:UIControlStateSelected];
        
        [_like addTarget:self action:@selector(didLikeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeLikeAction:)];
        
        [_like addGestureRecognizer:panGR];
        
    }
    return _like;
}

- (void)removeLikeAction:(UIPanGestureRecognizer *)panGR{
    
    //获取点
    CGPoint location = [panGR locationInView:self.view];
    
    CGFloat Margin = 23;
    if (location.x < Margin) {
        location.x = Margin;
    }
    if (location.x > kScreenSize.width - Margin) {
        location.x = kScreenSize.width - Margin;
    }
    if (location.y < 64 + Margin) {
        location.y = 64 + Margin;
    }
    if (location.y > kScreenSize.height - Margin) {
        location.y = kScreenSize.height - Margin;
    }
    
    self.like.center = location;
}

- (void)didLikeButtonTouched:(UIControl *)sender{
    
    if (self.like.selected) {
        [self.view showMessage:@"取消收藏"];
    }else{
        [PlistWorkTools collectionFood:self.model];
        [self.view showMessage:@"收藏成功"];
    }
    self.like.selected = !self.like.selected;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
    self.webView.scrollView.bounces = NO;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%ld",kDietBaikeDetailBasePath,(long)self.model.listID]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    [self like];
    
}

#pragma mark - 分享按钮

- (void)setupNav{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bt_list_more_share_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(didShareButtonTouched:)];
    
}
- (void)didShareButtonTouched:(UIControl *)sender{
    
    NSLog(@"点击了分享按钮");
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
