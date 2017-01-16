//
//  UNUserInfoViewController.m
//  PublicNews
//
//  Created by universe on 2016/12/11.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNUserInfoViewController.h"

#import "UNUserHeaderCell.h"
#import "UNEditUserNameController.h"



//#import "UNLoginViewController.h"

@interface UNUserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *imagePhoto;

@end

@implementation UNUserInfoViewController


- (instancetype)initWithStyle:(UITableViewStyle)style{

    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UNUserHeaderCell" bundle:nil] forCellReuseIdentifier:@"UNUserHeaderCell"];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
         UNUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UNUserHeaderCell" forIndexPath:indexPath];
       
        if (self.imagePhoto) {
            [cell.headerImageView setImage:self.imagePhoto];
        }else{
            if (self.info.avatar_large.length > 0) {
                [cell.headerImageView setImageWithURL:[NSURL URLWithString:self.info.avatar_large] placeholder:[UIImage imageNamed:@"share_qq_icon"]];
            }else{
                [cell.headerImageView setImage:[UIImage imageNamed:@"share_qq_icon"]];
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"昵称";
        cell.detailTextLabel.text = self.info.screen_name;
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        return 66;
    }else{
    
        return 44;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //弹出altersheet 选择
        //选择照片库
        [self changedHeaderImage];
    }
    
    if (indexPath.row == 1) {
        //清除用户信息
        UNEditUserNameController *editVC = [[UNEditUserNameController alloc] init];
        editVC.username = self.info.screen_name;
        editVC.backValueBlock = ^(NSString *usename){
            self.info.screen_name = usename;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:editVC animated:YES];
    }
    
   
    
}
#pragma mark 图片头像更改
- (void)changedHeaderImage{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setImagePhotoLibrary:UIImagePickerControllerSourceTypeCamera];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setImagePhotoLibrary:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alterVC addAction:action1];
    [alterVC addAction:action2];
    [alterVC addAction:actionCancle];
    
    [self presentViewController:alterVC animated:YES completion:nil];
    
    
}

- (void)setImagePhotoLibrary:(UIImagePickerControllerSourceType)sourceType{

    UIImagePickerController *photoVC = [[UIImagePickerController alloc] init];
    photoVC.delegate = self;
    photoVC.sourceType = sourceType;
    photoVC.allowsEditing = YES;
    [self presentViewController:photoVC animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"did_imagePickerController");
    
    //显示更换图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imagePhoto = image;
    [self.tableView reloadData];
    
    
    //上传图片
    
    BmobUser *user = [BmobUser currentUser];
    NSData *data = UIImagePNGRepresentation(image);
    BmobFile *file = [[BmobFile alloc] initWithFileName:@"header.jpg" withFileData:data];
    [self dismissViewControllerAnimated:YES completion:nil];
     [self.view showHUD];
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //将上传的图片和用户关联
            [user setObject:file.url forKey:@"headerImagePath"];
            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [self.view showMessage:@"头像更新成功"];
                }else{
                    [self.view showMessage:@"头像更新失败"];
                }
            }];
        }else{
            [self.view showMessage:@"头像更新失败"];
        }
    }];

    
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@"did_navigationController");
    
}




- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
