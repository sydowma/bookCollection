//
//  BookAuthorDAO.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAuthorDAO.h"

@implementation BookAuthorDAO

+ (long long)insertModel:(BookAuthor *)model withDataBase:(FMDatabase *)db {
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_AUTHOR (bookId, name) VALUES (?, ?)", @(model.bookId), model.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db {
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    NSMutableArray *results = [@[] mutableCopy];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    // BUG 这里没有执行
    while ([s next]) {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:s];
        [results addObject:author];
    }
    
    
//    [s close];
    
    
    return results;
}
@end
