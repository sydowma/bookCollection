//
//  BookDetailService.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookDetailService : NSObject


/**
 收藏图书

 @param bookEntity 图书实体
 @return 图书本地Id
 */
+ (long long)favBook: (BookEntity *)bookEntity;


/**
 使用豆瓣ID搜索数据库中是否有已经收藏的书籍

 @param doubanId 图书本地ID
 */
+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId;


/**
 取消收藏图书

 @param id 图书本地id
 @return <#return value description#>
 */
+ (BOOL)unFavBookWithId: (long long)id;
@end
