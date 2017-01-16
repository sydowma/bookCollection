//
//  BookAuthor.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseModel.h"
#import <UIKit/UIKit.h>

@interface BookAuthor : BookBaseModel


/**
 图书本地ID
 */
@property (nonatomic, assign) long long bookId;


/**
 作者名称
 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIColor *color;

@end
