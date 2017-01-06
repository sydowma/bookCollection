//
//  BookListTableViewCell+BookEntity.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListTableViewCell+BookEntity.h"

#import <UIImageView+WebCache.h>
#import "BookEntity.h"
#import "BookAuthor.h"
#import "BookTag.h"




@implementation BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    
    self.titleLabel.text = bookEntity.title;
    
    NSString *authorList = @"";
    
    for (BookAuthor *author in bookEntity.authors) {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    
    self.authorLabel.text = [NSString stringWithFormat:@"作者：%@", authorList];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
    // 标签
    // 相对定位的基准View
    
    UIView *lastDockView = self.tagsView;
    // 取出这本书的Tag，最多显示4个
    for (NSInteger i = 0; i < MIN(bookEntity.tags.count, 4); i++) {
        BookTag *tag = [bookEntity.tags objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        button.layer.cornerRadius = 2.0f;
        button.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        button.layer.borderWidth = 0.5f;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setContentEdgeInsets:UIEdgeInsetsMake(3.0f, 5.0f, 3.0f, 5.0f)];
        [button setTitle:tag.name forState:UIControlStateNormal];
        [button sizeToFit];
        
        [self.tagsView addSubview:button];
        
        if ([lastDockView isEqual:self.tagsView]) {
            [self.tagsView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|-0-[button]"
                                           options:NSLayoutFormatAlignAllCenterY
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(button)]];
            
            [self.tagsView addConstraint:[NSLayoutConstraint
                                          constraintWithItem:button
                                          attribute:  NSLayoutAttributeCenterY
                                          relatedBy:  NSLayoutRelationEqual
                                          toItem:     self.tagsView
                                          attribute:  NSLayoutAttributeCenterY
                                          multiplier: 1.0
                                          constant:   0]];
        } else {
            
            [self.tagsView addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:[lastDockView]-8-[button]"
                                           options:NSLayoutFormatAlignAllCenterY
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(lastDockView, button)]];
            
        }
        // 下面的button依赖于这个button来定位
        lastDockView = button;
        
    }
    
    // 自动布局Crash隐患: 如果没有Tag数据，就会Crash，没有容错处理
    // 最后一个button和右侧的textView
    [self.tagsView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[lastDockView]-0-|"
                                   options:0
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(lastDockView)]];
}

@end
