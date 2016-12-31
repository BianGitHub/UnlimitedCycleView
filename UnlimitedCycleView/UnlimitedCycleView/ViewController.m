//
//  ViewController.m
//  UnlimitedCycleView
//
//  Created by 边雷 on 16/12/31.
//  Copyright © 2016年 Mac-b. All rights reserved.
//

#import "ViewController.h"
#import "BLCycleView.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSArray<UIImage *> *_imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    BLCycleView *cycleView = [[BLCycleView alloc]init];
    // 再此传入一个图片数组即可
    cycleView.imageList = _imageList;
    [self.view addSubview: cycleView];
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@120);
    }];
}

//加载本地数据
- (void)loadData
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"Home_Scroll_%02zd.jpg", i+1] withExtension:nil];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [arrM addObject:image];
    }
    _imageList = arrM.copy;
}

@end
