//
//  PieChartView+Author.h
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "PieChartView.h"

@class BookEntity, AuthorModel;

@interface PieChartView (Author)

- (void)configureWithBookEntity:(NSArray<AuthorModel*> *)authors withRadius:(CGFloat)radius;

@end
