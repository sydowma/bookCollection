//
//  BookListTableViewCell.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseTableViewCell.h"

@interface BookListTableViewCell : BookBaseTableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *tagsView;

@end
