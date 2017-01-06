//
//  BookEntity.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/5.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseModel.h"

@interface BookEntity : BookBaseModel

@property (nonatomic, assign) long long id;

@property (nonatomic, assign) long long doubanId;

@property (nonatomic, copy) NSString *isbn10;

@property (nonatomic, copy) NSString *isbn13;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *doubanUrl;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *publisher;

@property (nonatomic, copy) NSString *pubdate;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *author_intro;

@property (nonatomic, copy) NSArray *authors;

@property (nonatomic, copy) NSArray *translators;

@property (nonatomic, copy) NSArray *tags;




@end
