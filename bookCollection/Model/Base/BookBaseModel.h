//
//  BookBaseModel.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface BookBaseModel : NSObject  <NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (id)copyWithZone:(NSZone *)zone;

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet;


#pragma mark - convert

- (NSArray *) modelArrayFromDictArray: (NSArray *)array withModelClass: (Class)modelClass;

@end
