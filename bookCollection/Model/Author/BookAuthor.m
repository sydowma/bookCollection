//
//  BookAuthor.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAuthor.h"
#import <FMDB/FMDB.h>

@implementation BookAuthor

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    BookAuthor *author = [[[self class] alloc] init];
    author.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    author.name = [dict objectForKey:@"name"];
    
    return author;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet {
    BookAuthor *bookAuthor = [[[self class] alloc] init];
    
    bookAuthor.bookId = [resultSet longLongIntForColumn:@"bookId"];
    bookAuthor.name= [resultSet stringForColumn:@"name"];
    
    
    return bookAuthor;
    
}

- (id)copyWithZone:(NSZone *)zone {
    BookAuthor *author = [[[self class] allocWithZone:zone] init];
    author.bookId = self.bookId;
    author.name = [self.name copy];
    
    return author;
}

@end
