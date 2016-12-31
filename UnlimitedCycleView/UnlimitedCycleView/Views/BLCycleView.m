//
//  BLCycleView.m
//  UnlimitedCycleView
//
//  Created by 边雷 on 16/12/31.
//  Copyright © 2016年 Mac-b. All rights reserved.
//

#import "BLCycleView.h"

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
    self.backgroundColor = [UIColor redColor];
}

@end
