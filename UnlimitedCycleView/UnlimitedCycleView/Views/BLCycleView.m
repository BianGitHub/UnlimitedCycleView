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
#import "BLCycleCell.h"
static NSString *cellID = @"cellID";
@interface BLCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, weak) UIPageControl *pageC;
@end

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
    cv.dataSource = self;
    cv.delegate = self;
    cv.pagingEnabled = YES;
    cv.showsHorizontalScrollIndicator = NO;
    [self addSubview:cv];
    
    [cv registerClass:[BLCycleCell class] forCellWithReuseIdentifier:cellID];
    
    UIPageControl *pageC = [[UIPageControl alloc]init];
    pageC.pageIndicatorTintColor = [UIColor grayColor];
    pageC.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:pageC];
    self.pageC = pageC;
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [pageC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(10);
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BLCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    cell.picture = _imageList[indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
//collectionView滚动时pageC跟着滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / scrollView.bounds.size.width;
    
    self.pageC.currentPage = page + 0.5;
}
//给pageC个数赋值
- (void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    
    self.pageC.numberOfPages = _imageList.count;
}

@end
