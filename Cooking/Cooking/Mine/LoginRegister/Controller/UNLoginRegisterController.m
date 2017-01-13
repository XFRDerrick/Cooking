//
//  UNLoginRegisterController.m
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNLoginRegisterController.h"
#import "UITextField+FormatJudge.h"

@interface UNLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *LoginMethodSegment;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UIButton *passBtn;

//获取验证码的定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation UNLoginRegisterController


- (IBAction)didLoginRegisterMethodChanged:(UISegmentedControl *)sender {
    [self.timer invalidate];
    [self.view endEditing:YES];
    
    if (sender.selectedSegmentIndex == 0) {
        self.accountTextField.placeholder = @"请输入账号：";
        self.accountTextField.keyboardType = UIKeyboardTypeDefault;
        self.passwordTextField.placeholder = @"请输入密码：";
        [self.accountBtn setTitle:@"账号" forState:UIControlStateNormal];
        [self.passBtn setTitle:@"密码" forState:UIControlStateNormal];
        [self.passBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.passBtn.selected = NO;
        self.passBtn.enabled = NO;
        
        
    }else{
        self.accountTextField.placeholder = @"请输入手机号：";
        self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        self.passwordTextField.placeholder = @"请输入验证码：";
        [self.accountBtn setTitle:@"手机号" forState:UIControlStateNormal];
        [self.passBtn setTitle:@"验证码" forState:UIControlStateNormal];
        
        UIColor *color = kRGBA_COLOR(90, 160, 241, 1) ;
        [self.passBtn setTitleColor:color forState:UIControlStateNormal];
        [self.passBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        self.passBtn.enabled = YES;
        self.passBtn.selected = NO;
    }
    
}

#pragma mark - 获取验证码
- (IBAction)getAuthCodeDidTouched:(UIButton *)sender {
    
    self.passBtn.enabled = NO;
    self.passBtn.selected = YES;
    //添加定时器 重新获取验证码
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:6 block:^(NSTimer * _Nonnull timer) {
        self.passBtn.enabled = YES;
        self.passBtn.selected = NO;
        UIColor *color = kRGBA_COLOR(90, 160, 241, 1) ;
        [self.passBtn setTitleColor:color forState:UIControlStateNormal];
       [self.timer invalidate];
    } repeats:NO];
    self.timer = timer;
    //请求验证码
    //判断手机号格式
    NSLog(@"已经请求验证码");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.LoginMethodSegment.selectedSegmentIndex = 0;
    self.title = @"登录/注册";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 登录按钮Action
- (IBAction)didLoginBtnTouched:(UIButton *)sender {
    
    if (self.LoginMethodSegment.selectedSegmentIndex == 0) {
        //普通登录
        if (![self.accountTextField isNULL] && ![self.passwordTextField isNULL]) {
            [self.view showHUD];
            [self bmobLogin];
        }else{
            [self.view showMessage:@"密码或账号不能为空！"];
        }
    }else{//手机登录
        
    }
}

- (void)bmobLogin{
    [BmobUser loginInbackgroundWithAccount:[self.accountTextField deleteBlankSpace] andPassword:[self.passwordTextField deleteBlankSpace] block:^(BmobUser *user, NSError *error) {
        if (user) {
            //登录成功直接返回之前界面
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [self.view hidenHUD];
            NSString *judgeStr = error.userInfo.allValues[0];
            if ([judgeStr containsString:@"incorrect"]) {
                [self showFailRegisterOrLoginWithTitle:@"登录失败" Message:@"账户名或密码不正确"];
                
            }else if ([judgeStr containsString:@"connect failed"]){
                [self showFailRegisterOrLoginWithTitle:@"登录失败" Message:@"请检查网络后重新登录"];
            }else{
                [self showFailRegisterOrLoginWithTitle:@"登录失败" Message:@"请重新输入账号和密码"];
            }
        }
    }];
    
}


#pragma mark - 注册按钮Action
- (IBAction)didRegisterBtnTouched:(UIButton *)sender {
    
    if (self.LoginMethodSegment.selectedSegmentIndex == 0) {
        //普通账号注册
        if (![self.accountTextField isNULL] && ![self.passwordTextField isNULL]) {
            [self.view showHUD];
            [self bmobRegister];
        }else{
            //提示输入不能为空
            [self.view showMessage:@"密码或账号不能为空！"];
        }
        
    }else{//手机账号注册
       
    }
    
    
}

#pragma mark - 注册方法
- (void)bmobRegister{
    //删除了首尾的空格
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:[self.accountTextField deleteBlankSpace]];
    [bUser setPassword:[self.passwordTextField deleteBlankSpace]];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [self.view showMessage:@"注册成功,请重新登录"];
            //会自动缓存注册的信息 需要清楚
            [BmobUser logout];
            
        } else {
            [self.view hidenHUD];
            NSString *userInfo = error.userInfo.allValues[0];
            NSString *judgeStr = userInfo;
            if ([judgeStr containsString:@"already taken"]) {
                [self showFailRegisterOrLoginWithTitle:@"注册" Message:@"用户名已存在"];
            }else if ([judgeStr containsString:@"connect failed"]){
                [self showFailRegisterOrLoginWithTitle:@"注册" Message:@"请检查网络后重新注册"];
            }else{
                [self showFailRegisterOrLoginWithTitle:@"注册" Message:@"请重新输入账号和密码"];
            }
        }
    }];
}
#pragma mark - 注册失败提示信息
- (void)showFailRegisterOrLoginWithTitle:(NSString *)title Message:(NSString *)message{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alterVC addAction:actionDone];
    [self presentViewController:alterVC animated:YES completion:nil];
}

#pragma mark - 第三方登录
- (IBAction)didQQLoginTouched:(UIButton *)sender {
}
- (IBAction)didWchatLoginTouched:(UIButton *)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}


@end
