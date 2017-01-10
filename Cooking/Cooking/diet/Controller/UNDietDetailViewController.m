//
//  UNDietDetailViewController.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietDetailViewController.h"

@interface UNDietDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

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
        [_headerLikeButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_normal"] forState:UIControlStateNormal];
        [_headerLikeButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_press"] forState:UIControlStateHighlighted];
        [_headerLikeButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_like_button_hl"] forState:UIControlStateSelected];
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
    
    NSLog(@"点击收藏按钮");
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
