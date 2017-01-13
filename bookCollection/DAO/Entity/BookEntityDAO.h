//
//  BookEntityDAO.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookEntity.h"

@interface BookEntityDAO : BookBaseDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db;

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db;

+ (NSArray<BookEntity *> *)queryAllModelsWithOffset: (long long)offset size: (NSInteger)size withDataBase: (FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db;

@end
