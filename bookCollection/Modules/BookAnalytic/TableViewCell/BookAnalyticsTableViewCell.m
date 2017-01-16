//
//  BookAnalyticsTableViewCell.m
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAnalyticsTableViewCell.h"
#import <Masonry.h>
#import "BookAuthor.h"

@implementation BookAnalyticsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
        
    }
    
    return self;
    
}

- (void)initSubviews {
    
    _authorNameLabel = [UILabel new];
    _authorNameLabel.textColor = [UIColor darkGrayColor];
    _authorNameLabel.font = [UIFont systemFontOfSize:15.0f];
    _authorNameLabel.numberOfLines = 0;
    [self.contentView addSubview:_authorNameLabel];
    
    [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/3*2);
    }];
    
    _bookCountLabel = [UILabel new];
    _bookCountLabel.text = @"1本";
    _bookCountLabel.textColor = [UIColor lightGrayColor];
    _bookCountLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_bookCountLabel];
    
    [_bookCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
        make.width.mas_equalTo(30);
        make.left.mas_equalTo(self.authorNameLabel.mas_right);
    }];
    
    _percentageLabel = [UILabel new];
    _percentageLabel.text = @"10%";
    _percentageLabel.textColor = [UIColor darkGrayColor];
    _percentageLabel.font = [UIFont systemFontOfSize:19.0f];
    _percentageLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_percentageLabel];
    
    [_percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
        make.right.mas_equalTo(-16);
        make.left.mas_equalTo(self.bookCountLabel.mas_right);
    }];
    
    
}

@end
