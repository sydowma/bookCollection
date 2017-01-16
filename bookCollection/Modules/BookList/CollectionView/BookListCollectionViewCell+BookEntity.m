//
//  BookListCollectionViewCell+BookEntity.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/13.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListCollectionViewCell+BookEntity.h"
#import <UIImageView+WebCache.h>
#import "BookEntity.h"

@implementation BookListCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    self.titleLabel.text = bookEntity.title;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
}

- (void)startDownloadCoverImageWithBookEntity:(BookEntity *)bookEntity {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
}

@end
