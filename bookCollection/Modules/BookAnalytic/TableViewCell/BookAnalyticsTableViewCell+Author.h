//
//  BookAnalyticsTableViewCell+Author.h
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAnalyticsTableViewCell.h"

@class BookEntity;

@interface BookAnalyticsTableViewCell (Author)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
