//
//  BookListTableViewCell.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListTableViewCell.h"

@implementation BookListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:13.0f];
    self.authorLabel.textColor = UIColorFromRGB(0x999999);
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.authorLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    self.tagsView = [[UIView alloc] init];
    self.tagsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.tagsView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_coverImageView, _authorLabel, _titleLabel, _tagsView);
    // 从左到右 15个点的空白，图片宽度50，间距15，标题右侧至少15个点空白 标题封面顶部对齐
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_coverImageView(==50)]-15-[_titleLabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    // 封面高度70， 顶部15的边距
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_coverImageView(==70)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    // label
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleLabel]-6-[_authorLabel]-10-[_tagsView(==18)]" options:NSLayoutFormatAlignAllLeft| NSLayoutFormatAlignAllRight metrics:nil views:views]];

}


/**
 在重用的时候把之前的清空
 */
- (void)prepareForReuse {
    self.titleLabel.text = nil;
    self.coverImageView.image = nil;
    self.authorLabel.text = nil;
    
    [self.tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
