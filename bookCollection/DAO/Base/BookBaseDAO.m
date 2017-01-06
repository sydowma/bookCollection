//
//  BookBaseDAO.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseDAO.h"

@implementation BookBaseDAO

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented ""for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookDAOMethodException" reason:msg userInfo:nil];
}

@end
