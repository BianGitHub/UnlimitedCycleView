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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BLCycleView *cycleView = [[BLCycleView alloc]init];
    [self.view addSubview: cycleView];
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(@120);
    }];
}

@end
