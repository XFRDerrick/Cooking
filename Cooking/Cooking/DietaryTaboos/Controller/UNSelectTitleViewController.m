//
//  UNSelectTitleViewController.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNSelectTitleViewController.h"
#import "UNTitleCell.h"
#import "UNSelectCReusableView.h"
#define kMargin 10

@interface UNSelectTitleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation UNSelectTitleViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupCollectionLayout];
}

- (void)setupCollectionLayout{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    layout.minimumLineSpacing = kMargin;
    layout.minimumInteritemSpacing = kMargin;
    
    CGFloat w = (long)((kScreenSize.width - 4 * kMargin)/3.0);
    CGFloat h = 33;
    layout.itemSize = CGSizeMake(w, h);
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"UNTitleCell" bundle:nil] forCellWithReuseIdentifier:@"titleCell"];
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"UNSelectCReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleHeader"];
    
}

- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UNTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    
    cell.titleLable.text = self.titles[indexPath.row];
    if (indexPath.row == self.currentIndex) {
        cell.titleLable.textColor = kRGBA_COLOR(100, 153, 249, 1);
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.returnIndexBlock(indexPath.row);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(kScreenSize.width, 45);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UNSelectCReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleHeader" forIndexPath:indexPath];
        view.title = @"我的选择";
        return view;
        

    }
    return nil;
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
