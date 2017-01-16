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
    
    author.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    author.name = [dict objectForKey:@"name"];
    
    float red = (arc4random() % 256);
    float green = (arc4random() % 256);
    float blue = (arc4random() % 256);
    
    author.color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
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
