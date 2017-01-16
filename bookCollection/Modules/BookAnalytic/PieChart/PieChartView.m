//
//  PieChartView.m
//  Demo02_饼图
//
//  Created by xiaoz on 15/9/22.
//  Copyright (c) 2015年 xiaoz. All rights reserved.
//

#import "PieChartView.h"
#import "BookAuthor.h"
#import "BookEntity.h"

@implementation PieChartView

- (void)drawRect:(CGRect)rect {
    
    CGFloat startA = M_PI_2*3;
    CGFloat endA = 0;
    // 遍历每一个数据，分别绘制圆弧
    for (NSArray *item in self.authorArr) {
        endA = startA + item.count/self.sumAuthorCount*2*M_PI;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2) radius:self.radius startAngle:startA  endAngle:endA clockwise:YES];
        //添加到圆心的直线
        [path addLineToPoint:CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2)];
        float red = (arc4random() % 256);
        float green = (arc4random() % 256);
        float blue = (arc4random() % 256);
        [[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:0.7] setFill];
        [path fill];
        //为下一个部分做准备，则开始弧度是上一次的结束弧度
        startA = endA;
    }
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2) radius:self.radius startAngle:0  endAngle:M_PI*2 clockwise:YES];
    path1.lineWidth = 4;
    [UIColorFromRGBA(0x00A58A, 0.9) setStroke];
    
    
    [path1 stroke];
    
    // 这里应该把接口抽取出来，在外部设置圆
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2) radius:self.radius-40 startAngle:0  endAngle:M_PI*2 clockwise:YES];
    path2.lineWidth = 5;
    [[UIColor whiteColor] setFill];
    [path2 fill];
    
    
    
//    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:30];
//    attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x009D82);
//    
////    [str drawAtPoint:CGPointMake(30, 100) withAttributes:attrs];
//    
//    //根据字符串的内容，算好刚好装下文字的高度
//    CGRect strRect = [@"12" boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
//    
//    [@"12" drawInRect:CGRectMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2+64/2, strRect.size.width, strRect.size.height) withAttributes:attrs];
    
    
//    for (int i = 1; i <= self.authorArr.count; i++) {
//        AuthorModel *author = [self.authorArr objectAtIndex:i-1];
//        
//        endA = startA + i/self.sumAuthorCount*2*M_PI;
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path addArcWithCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2) radius:self.radius startAngle:startA  endAngle:endA clockwise:YES];
//        //添加到圆心的直线
//        [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
//        float red = (arc4random() % 256);
//        float green = (arc4random() % 256);
//        float blue = (arc4random() % 256);
//        [[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1] setFill];
//        [path fill];
//        //为下一个部分做准备，则开始弧度是上一次的结束弧度
//        startA = endA;
//        
//    }
    
}

@end
