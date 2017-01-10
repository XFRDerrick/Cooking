//
//  UNFoodDetailController.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNFoodDetailController.h"

@interface UNFoodDetailController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation UNFoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]];
    
    
//    http://60.205.59.95/v1/dish/info?code=77222477
    
    NSString *path = @"http://60.205.59.95/v1/dish/info";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"77222477" forKey:@"code"];
    
     NSString *str1 = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [NetManager GET:str1 paramaters:dic completionHandler:^(id respondObj, NSError *error) {
       
        if (!error) {
            NSLog(@"----%@",respondObj);
        }
        
    }];
    
    
    NSString *contentStr = self.model.content;
    
    
    
    NSData *data = [NSData dataWithHexString:contentStr];
    
    
    
//    [self.webView loadData:data MIMEType:@"xml" textEncodingName:@"NSUTF8StringEncoding" baseURL:nil];
    
    [self.webView loadHTMLString:contentStr baseURL:nil];
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
