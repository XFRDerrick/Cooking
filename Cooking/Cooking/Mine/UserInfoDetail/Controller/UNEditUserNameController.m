//
//  UNEditUserNameController.m
//  Cooking
//
//  Created by universe on 2017/1/13.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNEditUserNameController.h"

@interface UNEditUserNameController ()
@property (weak, nonatomic) IBOutlet UITextField *usenameTextField;

@end

@implementation UNEditUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.usenameTextField.text = self.username;
    [self.usenameTextField becomeFirstResponder];
    
}
- (IBAction)saveBtnDidTouched:(UIButton *)sender {
    
    [self.view showHUD];
    self.backValueBlock(self.usenameTextField.text);
    //更新用户信息
    BmobUser *bUser = [BmobUser currentUser];
    //更新number为30
    [bUser setObject:self.usenameTextField.text forKey:@"username"];

    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [self.view showMessage:@"修改成功"];
            [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
                 [self.navigationController popViewControllerAnimated:YES];
            } repeats:NO];
        }else{
         [self.view showMessage:@"修改失败"];
        }
    }];
 
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
