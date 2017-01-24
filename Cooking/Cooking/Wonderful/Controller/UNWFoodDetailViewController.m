//
//  UNWFoodDetailViewController.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNWFoodDetailViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface UNWFoodDetailViewController ()

@property (nonatomic, strong) UIImageView *videoBackImageIV;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *share;
@property (nonatomic, strong) UIWebView *videoWebView;
@property (strong, nonatomic) UIWebView *webView;
/** 收藏 */
@property (nonatomic, strong) UIButton *like;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation UNWFoodDetailViewController

#pragma mark - 分享按钮
- (UIButton *)share {
    if(!_share) {
        _share = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - 15 - 40, 20, 40,40)];
        [self.view addSubview:_share];
        [self.view bringSubviewToFront:self.share];
        _share.selected = NO;
        _share.layer.cornerRadius = 45/2.0;
        [_share setImage:[UIImage imageNamed:@"bt_list_more_share_normal"] forState:UIControlStateNormal];
        [_share setImage:[UIImage imageNamed:@"bt_list_more_share_press"] forState:UIControlStateHighlighted];

        [_share addTarget:self action:@selector(didShareButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _share;
}
- (void)didShareButtonTouched:(UIControl *)sender{
    
    NSLog(@"点击了分享按钮");
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
        [PlistWorkTools collectionFood:self.dataModel];
        [self.view showMessage:@"收藏成功"];
        NSLog(@"收藏成功");
    }
    self.like.selected = !self.like.selected;
    
}

#pragma mark - 懒加载

- (UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, self.videoBackImageIV.frame.size.height, kScreenSize.width, kScreenSize.height - self.videoBackImageIV.frame.size.height);
        _webView.scrollView.bounces = NO;
        [self.view addSubview:_webView];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
    }
    return _webView;

}
- (UIImageView *)videoBackImageIV{

    if (!_videoBackImageIV) {
        _videoBackImageIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 230)];
        [self.view addSubview:_videoBackImageIV];
        [_videoBackImageIV setImageWithURL:[NSURL URLWithString:self.dataModel.imageUrl] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    }
    return _videoBackImageIV;
}

- (UIButton *)playButton{

    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [self.view addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoBackImageIV);
            make.width.height.mas_equalTo(60);
        }];
        [self.view bringSubviewToFront:_playButton];
        [_playButton setImage:[UIImage imageNamed:@"bt_playlist_play_normal"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"bt_playlist_play_press"] forState:UIControlStateHighlighted];
        [_playButton addTarget:self action:@selector(playVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
- (void)playVideoAction:(UIButton *)sender{
    //开始播放
     self.playButton.hidden = YES;
    
//    _player = [AVPlayer playerWithURL:[NSURL URLWithString:self.dataModel.detailsUrl]];
//    [_player play];
//    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
//    [self.view.layer addSublayer:_playerLayer];
//    _playerLayer.frame = self.videoBackImageIV.frame;
//    //视频保持比例充满屏幕
//    _playerLayer.videoGravity = @"AVLayerVideoGravityResizeAspectFill";
//    
//    [self.view bringSubviewToFront:self.backButton];

    self.videoWebView = [[UIWebView alloc] initWithFrame:self.videoBackImageIV.frame];
    self.videoWebView.allowsPictureInPictureMediaPlayback = YES;
    self.videoWebView.mediaPlaybackAllowsAirPlay = YES;
    self.videoWebView.scrollView.bounces = NO;
    [self.view addSubview:self.videoWebView];
    NSURL *videoURL = [NSURL URLWithString:self.dataModel.detailsUrl];
    NSURLRequest *videoreq = [NSURLRequest requestWithURL:videoURL];
    
    [self.videoWebView loadRequest:videoreq];
    [self.view bringSubviewToFront:self.backButton];
    [self.view bringSubviewToFront:self.share];
    
    [self.view bringSubviewToFront:self.webView];
    [self.view bringSubviewToFront:self.like];
}


- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 50, 50)];
        [self.view addSubview:_backButton];
        [self.view bringSubviewToFront:_backButton];
        [_backButton setImage:[UIImage imageNamed:@"bt_listen-knowledge_share_button_normal"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backListVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
    
}
- (void)backListVC:(UIButton *)sender{
    //开始播放
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self playButton];
    [self backButton];
    [self share];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:kCookMenu,self.dataModel.ID]];
    NSURLRequest *req = [NSURLRequest requestWithURL:URL];
    
    [self.webView loadRequest:req];
    [self like];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
@end
