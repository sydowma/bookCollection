//
//  BookEntityDAO.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookEntityDAO.h"

@implementation BookEntityDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db {
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_ENTITY (doubanId, isbn10, isbn13, title, doubanUrl, image, publisher, pubdate, price, summary, author_intro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", @(bookEntity.doubanId), bookEntity.isbn10, bookEntity.isbn13, bookEntity.title, bookEntity.doubanUrl, bookEntity.image, bookEntity.publisher, bookEntity.pubdate, bookEntity.price, bookEntity.summary, bookEntity.author_intro];
    
    if (success) {
        // 返回最后一行记录的Id
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}


+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db {
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY WHERE doubanId = ?", @(doubanId)];
    if ([s next]) {
        // 转化Model
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        return entity;
    }
    return nil;
}

+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db {
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_ENTITY WHERE id = ?", @(id)];
    return success;
}

// 这里并没有真正的取出所有的Model
+ (NSArray<BookEntity *> *)queryAllModelsWithOffset:(long long)offset size:(NSInteger)size withDataBase:(FMDatabase *)db {
    NSMutableArray * results = [@[] mutableCopy];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY order by id desc limit ?, ?", @(offset), @(size)];
    while ([s next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        [results addObject:entity];
    }
//    [s close];
    
    return results;
}

@end
