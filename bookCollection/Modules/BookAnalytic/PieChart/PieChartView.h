//
//  PieChartView.h
//  Demo02_饼图
//
//  Created by xiaoz on 15/9/22.
//  Copyright (c) 2015年 xiaoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookEntity, AuthorModel;

@interface PieChartView : UIView

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSArray<AuthorModel *> *authorArr;

@property (nonatomic, assign) CGFloat sumAuthorCount;

@end








