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

+ (dispatch_queue_t)serviceQueue {
    static dispatch_queue_t service_queue;
    static dispatch_once_t serviceToken;
    dispatch_once(&serviceToken, ^{
        // queue 名   线性执行
        service_queue = dispatch_queue_create("book.service.list", DISPATCH_QUEUE_SERIAL);
    });
    return service_queue;
}

+ (void)getBookEntityListWithOffset:(long long)offset size:(NSInteger)size completion:(void (^)(NSArray<BookEntity *> *))completionHandler {
    
    // 把db的操作放到异步线程
    dispatch_async([[self class] serviceQueue], ^{
        FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
        if (![db open]) {
            // 如果失败了， 这里最好返回一个fail handler
            if (completionHandler) {
                completionHandler(@[]);
            }
            return ;
        }
        
        NSArray *bookEntities = [BookEntityDAO queryAllModelsWithOffset:offset size:size withDataBase:db];
        
        // 这里要取出Tag，Author，Translator
        for (BookEntity *entity in bookEntities) {
            entity.authors = [BookAuthorDAO queryModelsWithBookId: entity.id withDataBase: db];
            entity.translators = [BookTranslatorDAO queryModelsWithBookId:entity.id withDataBase:db];
            entity.tags = [BookTagDAO queryModelsWithBookId:entity.id withDataBase:db];
        }
        [db close];
        
        // 在主线程返回出去，不然会出奇怪的问题
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(bookEntities);
            }
        });
        
    });
    
}



@end
