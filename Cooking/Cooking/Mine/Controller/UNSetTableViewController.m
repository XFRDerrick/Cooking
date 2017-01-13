//
//  UNSetTableViewController.m
//  Cooking
//
//  Created by universe on 2017/1/12.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNSetTableViewController.h"
#import "UNSetTableViewCell.h"
#import "UNMainTarBarController.h"

@interface UNSetTableViewController ()

@end

@implementation UNSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UNSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"setCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
       
            [cell.imageIV setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"share_qq_icon"]];
            cell.contentLable.text = @"用户昵称";
            cell.actionLable.text = @"退出登录";
//            cell.detailTextLabel.textColor = kRGBA_COLOR(100, 153, 249, 1);
    }else if (indexPath.section == 1){
    
        [cell.imageIV setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"bt_list_more_share_normal"]];
        cell.contentLable.text = @"推荐美食天地给朋友";
        cell.actionLable.hidden = YES;

    }else{
        [cell.imageIV setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"like_s"]];
        cell.contentLable.text = @"去为美食天地评分";
        cell.actionLable.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        [self addAlterVCWithTitle:nil message:@"退出登录" handler:^{
            //重新加载应用
            [BmobUser logout];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UNMainTarBarController *tabVC = [[UNMainTarBarController alloc] init];
            window.rootViewController = tabVC;
            [window makeKeyAndVisible];
            
        }];
        
    }
    
}

- (void)addAlterVCWithTitle:(nullable NSString *)title message:(nullable NSString *)message handler:(void (^)())comHandler{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        comHandler();
    }];
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionDone];
    
    [self presentViewController:alterVC animated:YES completion:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
