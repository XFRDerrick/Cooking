//
//  UNCookingStyleCell.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCookingStyleCell.h"

#import "UNCookFoodCollectionCell.h"

@interface UNCookingStyleCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *cookingStyleLable;
@property (weak, nonatomic) IBOutlet UIButton *showAllButton;



@end

@implementation UNCookingStyleCell

#pragma mark - 参数赋值
- (void)setHeaderTitle:(NSString *)headerTitle{
    _headerTitle = headerTitle;
    self.cookingStyleLable.text = headerTitle;
}

- (void)setPosts:(NSArray<CookingStylePostsModel *> *)posts{
    _posts = posts;
    [self.collectionView reloadData];
}

#pragma mark - 界面
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self collectionSetup];
    [self setShowAllButtonAction];
}

- (void)setShowAllButtonAction{

    [self.showAllButton addTarget:self action:@selector(didTouchedAllButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
//代理方法
- (void)didTouchedAllButton:(UIButton *)sender{

    [self.delegate cookingStyleCell:self didClickShowAllButton:sender];
    
}


- (void)collectionSetup{

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat w = (long)((kScreenSize.width - 10 * 3) / 5.0 * 2);
    CGFloat h = w + 21 * 2 + 15;
    layout.itemSize = CGSizeMake(w, h);
    self.collectionView.collectionViewLayout = layout;
    ///

    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"UNCookFoodCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"foodCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UNCookFoodCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodCell" forIndexPath:indexPath];
    if (self.posts.count > 0) {
//        NSLog(@"posts.count:%ld item:%ld",self.posts.count,indexPath.item);
        CookingStylePostsModel *model = self.posts[indexPath.row];
        
        [cell.foodImageIV setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
        cell.foodNameLable.text = model.title;
        cell.foodDetailLable.text = model.excerpt;
    }else{
        [cell.foodImageIV setImage:[UIImage imageNamed:@"background_image.jpeg"]];
        cell.foodNameLable.text = @"";
        cell.foodDetailLable.text = @"";
  
    }

    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
