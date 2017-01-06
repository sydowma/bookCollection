//
//  BookTagDAO.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookTagDAO.h"

@implementation BookTagDAO

+ (long long)insertModel:(BookTag *)model withDataBase:(FMDatabase *)db {
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TAG (bookId, name, count) VALUES (?, ?, ?)", @(model.bookId), model.name, @(model.count)];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db {
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    NSMutableArray *results = [@[] mutableCopy];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    while ([s next]) {
        BookTag *tag = [[BookTag alloc] initWithFMResultSet:s];
        [results addObject:tag];
    }
    
    
    return results;
}

@end
