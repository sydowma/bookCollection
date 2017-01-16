//
//  BookCollectionViewCell.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookListCollectionViewCell : UICollectionViewCell


/**
 封面
 */
@property (nonatomic, strong) UIImageView *coverImageView;


/**
 书名
 */
@property (nonatomic, strong) UILabel *titleLabel;

@end
