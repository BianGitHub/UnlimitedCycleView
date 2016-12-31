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
@property(nonatomic, weak) UICollectionView *cv;
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
    self.cv = cv;
    
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
    return _imageList.count * 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BLCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    cell.picture = _imageList[indexPath.item % _imageList.count];
    return cell;
}

#pragma mark - UICollectionViewDelegate
//collectionView滚动时pageC跟着滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / scrollView.bounds.size.width;
    
    self.pageC.currentPage = (NSInteger)(page + 0.5) % _imageList.count;
}
// 当scrollView停止减速的时候, 会调用这个方法->也就是停止滚动的时候会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1.获取到停止滚动的时候, 当前显示的是第几个cell  visibleCells:可见的cell数组
    UICollectionViewCell *cell = [[self.cv visibleCells] lastObject];
    //2. 根据cell, 拿到这个cell的indexPath
    NSIndexPath *indexP = [self.cv indexPathForCell:cell];
    //3. 判断当前的cell是否是最后一个
        //先获取collectionView里一共有多少个cell
        //第0组里一共有多少个item
    NSInteger itemCount = [self.cv numberOfItemsInSection:0];
        //判断
    if (indexP.item == itemCount - 1) {
        //让scrollview跳转到图片的个数 - 1个item
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:_imageList.count - 1 inSection:0];
        //不能给动画
        [self.cv scrollToItemAtIndexPath:toIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //如果滚动到第0个条目
}

//给pageC个数赋值
- (void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    
    self.pageC.numberOfPages = _imageList.count;
}

@end
