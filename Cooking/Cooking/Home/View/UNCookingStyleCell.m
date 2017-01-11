//
//  UNCookingStyleCell.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCookingStyleCell.h"

//#import "UNCookFoodCollectionCell.h"
#import "UNHomeCollectionViewCell.h"

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

- (void)setLinks:(NSArray<HomeMenuLinksModel *> *)links{
    _links = links;
    
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
    CGFloat h = w + 30;
    layout.itemSize = CGSizeMake(w, h);
    self.collectionView.collectionViewLayout = layout;
    ///
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"UNHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"homeCVCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.links.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UNHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCVCell" forIndexPath:indexPath];
    if (self.links.count > 0) {
        
        HomeMenuLinksModel *model = self.links[indexPath.row];
        cell.model = model;
    }
    cell.tag = self.tag;
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
