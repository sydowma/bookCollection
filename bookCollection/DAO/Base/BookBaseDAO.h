//
//  BookBaseDAO.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "BookBaseModel.h"

@interface BookBaseDAO : NSObject

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db;

@end
