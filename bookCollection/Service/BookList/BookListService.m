//
//  BookListService.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListService.h"

#import "BookTagDAO.h"
#import "BookAuthorDAO.h"
#import "BookEntityDAO.h"
#import "BookTranslatorDAO.h"

#import "BookDBHelper.h"

@implementation BookListService

+ (NSArray<BookEntity *> *)getAllBookEntities {
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    NSArray *bookEntities = [BookEntityDAO queryAllModelsWithDataBase: db];
    
    // 这里要取出Tag，Author，Translator
    for (BookEntity *entity in bookEntities) {
        entity.authors = [BookAuthorDAO queryModelsWithBookId: entity.id withDataBase: db];
        entity.translators = [BookTranslatorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.tags = [BookTagDAO queryModelsWithBookId:entity.id withDataBase:db];
    }
    [db close];
    
    return bookEntities;
    
}



@end
