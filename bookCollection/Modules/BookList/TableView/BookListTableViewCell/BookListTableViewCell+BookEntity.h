//
//  BookListTableViewCell+BookEntity.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//  定义和实现BookListTableView接口，保证Cell 和 Category的分离
/*
 如果以后需要增加功能，只需要继承Cell，增加Category即可
 */


#import "BookListTableViewCell.h"

@class BookEntity;

@interface BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity: (BookEntity *)bookEntity;

@end
