//
//  BookTranslatorDAO.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookTranslatorDAO.h"

@implementation BookTranslatorDAO

+ (long long)insertModel:(BookTranslator *)model withDataBase:(FMDatabase *)db {
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TRANSLATOR (bookId, name) VALUES (?, ?)", @(model.bookId), model.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}


+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db {
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    NSMutableArray *results = [@[] mutableCopy];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    while ([s next]) {
        BookTranslator *translator = [[BookTranslator alloc] initWithFMResultSet:s];
        [results addObject:translator];
    }
    
    
    return results;
}


@end
