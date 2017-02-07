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
#define kSeed 1000
static NSString *cellID = @"cellID";
@interface BLCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, weak) UIPageControl *pageC;
@property(nonatomic, weak) UICollectionView *cv;
@property(nonatomic, strong) NSTimer *timer;
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
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageList.count*kSeed *0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    });
    
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
    
    // 创建定时器
    // 不能把定时器以默认的形式添加到运行循环  -> 当界面有其他滚动的控件时会有BUG 停止滚动
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playPicture) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(playPicture) userInfo:nil repeats:YES];
    //以通用的模式把定时器添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
// 定时器方法    ->让collectionView进行滚动
- (void)playPicture
{
    NSLog(@"xxxxxxx");
    // 获取collectionView当前滚动的偏移量x
    CGFloat offectX = self.cv.contentOffset.x;
    offectX += self.cv.bounds.size.width;
    // 把原来的偏移量加一个collectionView宽度   并设置给collectionView
    // 需要动画
    [self.cv setContentOffset:CGPointMake(offectX, 0) animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageList.count * kSeed;
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
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:_imageList.count * kSeed *0.5 - 1 inSection:0];
        //不能给动画
        [self.cv scrollToItemAtIndexPath:toIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //如果滚动到第0个条目就跳转到    ->第一次滚动需要在layoutSubviews里面设置
    if(indexP.item == 0)
    {
        //让cell滚动到中间cell位置
        [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageList.count*kSeed *0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

//当scrollview将要被拖拽的时候, 会调用这个方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 把定时器停掉
    self.timer.fireDate = [NSDate distantFuture];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //从现在开始隔2秒以后开火(自动滚动)
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}

// 加载完界面就让其滚动到_imageList.count的item上
// 也可以利用 '主队列异步' 保证数据源方法执行完毕之后再滚动到item上
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imageList.count*kSeed *0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

//给pageC个数赋值
- (void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    
    self.pageC.numberOfPages = _imageList.count;
}

//当无限轮播从父控件上移除的时候，把定时器给停掉   ->在delloc方法中移除不会停止
- (void)removeFromSuperview{
    [super removeFromSuperview];
    //停掉定时器
    [self.timer invalidate];
}

@end
