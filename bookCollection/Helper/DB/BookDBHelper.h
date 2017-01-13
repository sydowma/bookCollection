//
//  BookDBHelper.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDBHelper : NSObject

+ (NSString *)dbFolder;

+ (NSString *)dbPath;

+ (void)buildDataBase;

+ (void)resetDataBase;

@end
