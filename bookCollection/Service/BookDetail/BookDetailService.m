//
//  BookDetailService.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookDetailService.h"

#import "BookTagDAO.h"
#import "BookAuthorDAO.h"
#import "BookEntityDAO.h"
#import "BookTranslatorDAO.h"

#import "BookDBHelper.h"

#import <FMDB/FMDB.h>

@implementation BookDetailService

+ (long long)favBook: (BookEntity *)bookEntity {
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    // 保存图书
    long long bookId = [BookEntityDAO insertModel:bookEntity withDataBase:db];
    if (!bookId) {
        return bookId;
    }
    
    /**
     这里的bookId是根据最后一次插入的行记录来

     */
    
    // 保存作者
    [bookEntity.authors enumerateObjectsUsingBlock:^(BookAuthor*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookAuthorDAO insertModel:obj withDataBase:db];
    }];
    
    // 保存译者
    [bookEntity.translators enumerateObjectsUsingBlock:^(BookTranslator*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTranslatorDAO insertModel:obj withDataBase:db];
    }];
    
    // 保存Tag
    [bookEntity.tags enumerateObjectsUsingBlock:^(BookTag*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTagDAO insertModel:obj withDataBase:db];
    }];
    
    [db close];
    return bookId;
}

// 查看之前有没有收藏过
+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId {
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }

    BookEntity *book = [BookEntityDAO queryModelByDoubanId:doubanId withDataBase:db];
    
    [db close];
    return book;
}

+ (BOOL)unFavBookWithId:(long long)id {
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if(![db open]) {
        return NO;
    }
    
    [BookAuthorDAO deleteModelWithBookId:id withDataBase:db];
    [BookTranslatorDAO deleteModelWithBookId:id withDataBase:db];
    [BookTagDAO deleteModelWithBookId:id withDataBase:db];
    
    BOOL success = [BookEntityDAO deleteModelWithId:id withDataBase:db];
    
    [db close];
    
    return success;
    
}

@end
