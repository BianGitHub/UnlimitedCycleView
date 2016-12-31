//
//  BLCycleView.m
//  UnlimitedCycleView
//
//  Created by 边雷 on 16/12/31.
//  Copyright © 2016年 Mac-b. All rights reserved.
//

#import "BLCycleView.h"
#import "BLCycleLayout.h"
#import "Masonry.h"

@implementation BLCycleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
//    self.backgroundColor = [UIColor redColor];
    BLCycleLayout *layout = [[BLCycleLayout alloc]init];
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:cv];
    
    UIPageControl *pageC = [[UIPageControl alloc]init];
    pageC.numberOfPages = 3;
    pageC.pageIndicatorTintColor = [UIColor grayColor];
    pageC.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:pageC];
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [pageC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(10);
    }];
}

@end
