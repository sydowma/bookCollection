//
//  BookTranslatorDAO.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTranslator.h"

@interface BookTranslatorDAO : BookBaseDAO

+ (long long)insertModel:(BookTranslator *)model withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase: (FMDatabase *)db;

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
