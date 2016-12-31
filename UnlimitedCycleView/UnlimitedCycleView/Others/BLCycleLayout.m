//
//  BLCycleLayout.m
//  UnlimitedCycleView
//
//  Created by 边雷 on 16/12/31.
//  Copyright © 2016年 Mac-b. All rights reserved.
//

#import "BLCycleLayout.h"

@implementation BLCycleLayout

- (void)prepareLayout
{
    [super prepareLayout];
    //设置item大小
    self.itemSize = self.collectionView.bounds.size;
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置行间距为0
    self.minimumLineSpacing = 0;
}

@end
