//
//  BookAnalyticsTableViewCell+Author.m
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAnalyticsTableViewCell+Author.h"

#import "BookEntity.h"
#import "BookAuthor.h"

@implementation BookAnalyticsTableViewCell (Author)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    
    NSString *authorList = @"";
    for (BookAuthor *author in bookEntity.authors) {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    self.authorNameLabel.text = [NSString stringWithFormat:@"%@", authorList];
    
    
}

@end
