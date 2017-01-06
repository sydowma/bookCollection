//
//  BookTagDAO.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTag.h"

@interface BookTagDAO : BookBaseDAO

+ (long long)insertModel:(BookTag *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db;

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;
@end
