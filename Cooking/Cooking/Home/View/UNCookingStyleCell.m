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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cookingStyleLable.text = @"粤菜";
    
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
    
//    cell.layer.cornerRadius = 3;
//    cell.layer.masksToBounds = YES;
//    cell.layer.borderWidth = 1;
//    cell.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    
    
    [cell.foodImageIV setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    
    cell.foodNameLable.text = @"麻辣干锅鸭";
    cell.foodDetailLable.text = @"难度：配菜(中级) 时间：10-30分钟主料鸭腿3只小葱头6个美人椒2个干辣椒4个香葱2根姜1小块蒜3瓣辅料 花椒十几粒大料1个香叶一片盐2茶匙白胡椒半茶匙鸡精半茶匙料酒4勺老抽";
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
