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
@property (nonatomic, strong) UIWebView *videoWebView;
@property (strong, nonatomic) UIWebView *webView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation UNWFoodDetailViewController

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
    [self.view bringSubviewToFront:self.webView];
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
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:kCookMenu,self.dataModel.ID]];
    NSURLRequest *req = [NSURLRequest requestWithURL:URL];
    
    [self.webView loadRequest:req];
    
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
