//
//  BookBaseModel.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseModel.h"

@implementation BookBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    // 不应该使用基类，所以这里抛出一个异常
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented ""for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented ""for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
}

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented ""for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];

}

#pragma mark - convert

- (NSArray *) modelArrayFromDictArray: (NSArray *)array withModelClass: (Class)modelClass {
    // 对传入数据进行断言
    NSParameterAssert(modelClass != nil);
    NSParameterAssert([modelClass isSubclassOfClass:BookBaseModel.class]);
    
    NSMutableArray *models = [@[] mutableCopy];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookBaseModel *model = [[modelClass alloc] initWithDictionary:obj];
        [models addObject:model];
    }];
    return models;
}
@end

