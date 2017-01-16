//
//  BookCollectionViewCell.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation BookListCollectionViewCell


/**
 UICollectionView会默认调用此方法

 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.coverImageView];
//    self.coverImageView.frame = CGRectMake(0, 40, 80, 100);
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;

    
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.titleLabel.frame = CGRectMake(0, 140, 80, 30);
    self.titleLabel.numberOfLines = 2;
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_offset(CGPointMake(0, -15));
//        make.size.mas_equalTo(CGSizeMake(70, 110));
        make.top.equalTo(self.contentView);
//        make.bottom.equalTo(self.titleLabel).offset(-30);
        make.left.right.equalTo(self.contentView);
        
//        make.height.equalTo(@(130));
//        make.width.equalTo(@(105));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(5);
////        make.height.equalTo(@(30));
//        make.centerX.equalTo(self.coverImageView);
//        make.top.mas_equalTo(self.coverImageView).offset(8);
    }];
    
    
}


/**
 重用之前清空
 会产生复用问题，猜测是
 */
//-(void)prepareForReuse {
//    [super prepareForReuse];
//    self.coverImageView = nil;
//    self.titleLabel = nil;
//    
//}


@end
