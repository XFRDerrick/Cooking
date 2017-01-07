//
//  UNWonderMenuLayout.m
//  Cooking
//
//  Created by universe on 2017/1/7.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNWonderMenuLayout.h"

@interface UNWonderMenuLayout ()


@property (nonatomic, assign) CGFloat firstItemTransform;

@end

@implementation UNWonderMenuLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.itemSize = CGSizeMake(kScreenSize.width, (kScreenSize.height - 64- 100) / 2.0);
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return self;
}
//每次手指滑动时，都会调用这个方法来返回每个cell的布局
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    __block UICollectionViewLayoutAttributes *headerAttributes = nil;
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;

        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }else {
            [self updateCellAttributes:attributes withSectionHeader:headerAttributes];
            
        }
    }];
    
    return allItems;
    
}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//   
//}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    
    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxY = attributes.frame.origin.y - CGRectGetHeight(headerAttributes.bounds);
    CGFloat finalY = MAX(minY, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
    
    
    if (self.firstItemTransform) {
        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
    }
    
    origin.y = finalY;
    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.zIndex = attributes.indexPath.row;
    
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
