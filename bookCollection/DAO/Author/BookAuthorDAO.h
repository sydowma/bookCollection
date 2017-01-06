//
//  BookAuthorDAO.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookAuthor.h"

@interface BookAuthorDAO : BookBaseDAO

+ (long long)insertModel:(BookAuthor *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db;

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
