//
//  BLCycleCell.m
//  UnlimitedCycleView
//
//  Created by 边雷 on 16/12/31.
//  Copyright © 2016年 Mac-b. All rights reserved.
//

#import "BLCycleCell.h"
#import "Masonry.h"

@interface BLCycleCell ()
@property(nonatomic, weak) UIImageView *imageView;
@end

@implementation BLCycleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setPicture:(UIImage *)picture
{
    _picture = picture;
    
    self.imageView.image = _picture;
}

@end
