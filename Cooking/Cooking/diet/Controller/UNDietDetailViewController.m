//
//  UNDietDetailViewController.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietDetailViewController.h"

@interface UNDietDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;//网页
//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
//收藏按钮
@property (nonatomic, strong) UIButton *like;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *headerBackButton;
@property (nonatomic, strong) UIButton *headerLikeButton;
@property (nonatomic, strong) UILabel *titleLable;


@end

@implementation UNDietDetailViewController

- (UILabel *)titleLable{

    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        [self.headerView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headerView);
            make.top.equalTo(self.headerView).offset(27);
            make.height.mas_equalTo(30);
        }];
        _titleLable.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable;
}

- (UIButton *)headerBackButton{

    if (!_headerBackButton) {
        _headerBackButton = [[UIButton alloc] init];
        [self.headerView addSubview:_headerBackButton];
        [_headerBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerView).offset(15);
            make.bottom.equalTo(self.headerView).offset(-7);
            make.height.width.mas_equalTo(30);
        }];
        [_headerBackButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_share_button_normal"] forState:UIControlStateNormal];
        [_headerBackButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_share_button_press"] forState:UIControlStateHighlighted];
        [_headerBackButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBackButton;
}

- (UIButton *)headerLikeButton{

    if (!_headerLikeButton) {
        _headerLikeButton = [[UIButton alloc] init];
        [self.headerView addSubview:_headerLikeButton];
        [_headerLikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headerView).offset(-15);
            make.bottom.equalTo(self.headerView).offset(-7);
            make.height.width.mas_equalTo(30);
        }];
        [_headerLikeButton setImage:[UIImage imageNamed:@"bt_list_more_share_normal"] forState:UIControlStateNormal];
        [_headerLikeButton setImage:[UIImage imageNamed:@"bt_list_more_share_press"] forState:UIControlStateHighlighted];
        
        [_headerLikeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerLikeButton;
}

- (UIView *)headerView{

    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, kScreenSize.width, 64)];
        [self.view addSubview:_headerView];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, kScreenSize.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_headerView addSubview:lineView];
    }
    return _headerView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWeb];
    [self like];
    [self setupHeaderView];
    
}

- (void)setupHeaderView{

    [self headerBackButton];
    [self headerLikeButton];
    self.titleLable.text = self.model.title;
}

- (void)setupWeb{

    self.webView.scrollView.bounces = NO;
    NSURL *url = [NSURL URLWithString:self.model.page_url];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.webView.scrollView.delegate = self;
    [self.webView loadRequest:req];
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.webView.scrollView.contentOffset.y > 180) {
        self.backButton.alpha = 0;
        self.likeButton.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.headerView.frame = CGRectMake(0, 0, kScreenSize.width, 64);
        }];
    }
    if (self.webView.scrollView.contentOffset.y < 180) {
        self.backButton.alpha = 1;
        self.likeButton.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.headerView.frame = CGRectMake(0, -64, kScreenSize.width, 64);
        }];
    }
    
    
}


- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)likeAction:(UIButton *)sender {
    
    NSLog(@"点击分享按钮");
}


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
        NSLog(@"收藏成功");
    }
    self.like.selected = !self.like.selected;
    
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
