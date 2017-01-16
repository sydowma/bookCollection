//
//  PieChartView+Author.m
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "PieChartView+Author.h"

#import "BookEntity.h"
#import "BookAuthor.h"

@implementation PieChartView (Author)

- (void)configureWithBookEntity:(NSArray<AuthorModel*> *)authors withRadius:(CGFloat)radius {
    
    for (NSArray *item in authors) {
        self.sumAuthorCount += item.count;
    }
    
    self.authorArr = authors;
    
    self.radius = radius;
    
}

@end
