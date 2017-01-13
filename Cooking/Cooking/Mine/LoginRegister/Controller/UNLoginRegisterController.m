//
//  UNLoginRegisterController.m
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNLoginRegisterController.h"

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
- (IBAction)didLoginBtnTouched:(UIButton *)sender {
}
- (IBAction)didRegisterBtnTouched:(UIButton *)sender {
}
- (IBAction)didQQLoginTouched:(UIButton *)sender {
}
- (IBAction)didWchatLoginTouched:(UIButton *)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}


- (void)dealloc{
 
    NSLog(@"释放了吗？？");
    
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
