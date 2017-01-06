//
//  BookListService.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookListService : NSObject

+ (NSArray<BookEntity *> *)getAllBookEntities;

@end
