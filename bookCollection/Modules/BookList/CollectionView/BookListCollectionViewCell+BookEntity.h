//
//  BookListCollectionViewCell+BookEntity.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListCollectionViewCell.h"
@class BookEntity;

@interface BookListCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

- (void)startDownloadCoverImageWithBookEntity:(BookEntity *)bookEntity;
@end
