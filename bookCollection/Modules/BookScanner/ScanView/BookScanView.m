//
//  BookScanView.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookScanView.h"

@interface BookScanView ()
//{
//    CGFloat _minX;
//    CGFloat _maxX;
//    CGFloat _minY;
//    CGFloat _maxY;
//}




/**
 扫描区域
 */
@property (nonatomic, assign) CGSize rectSize;

/**
 扫描区域相对于中心点的偏移量，向上为负，向下为正
 */
@property (nonatomic, assign) CGFloat offsetY;


/**
 扫描线
 */
@property (nonatomic ,strong) UIImageView *animationLine;


/**
 是否反向扫描
 */
@property (nonatomic, assign, getter=isAnimationReverse) BOOL animationReverse;


/**
 是否正在扫描
 */
@property (nonatomic, assign,getter=isAnimating) BOOL animating;



@end

@implementation BookScanView


/**
 <#Description#>

 @param frame <#frame description#>
 @param size <#size description#>
 @param offsetY 相对于中间的偏移
 */
- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY {
    self = [super initWithFrame:frame];
    if (self) {
        self.rectSize = size;
        self.offsetY = offsetY;
        
        // 计算基准坐标
        _minX = (self.frame.size.width - self.rectSize.width) / 2;
        _maxX = _minX + self.rectSize.width;
        _minY = (self.frame.size.height - self.rectSize.height) / 2 + self.offsetY;
        _maxY = self.rectSize.height + _minY;
        
    }
    return self;
}

// 画中间扫描区域的遮罩
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    

    
    // 绘制半透明灰色区域
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, _minY));
    CGContextFillRect(context, CGRectMake(0, _minY, _minX, self.rectSize.height));
    CGContextFillRect(context, CGRectMake(0, _maxY, self.frame.size.width, self.frame.size.height - _maxY));
    CGContextFillRect(context, CGRectMake(_maxX, _minY, _minX, self.rectSize.height));
    
    // 绘制中间区域的白色边框
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    
    CGContextAddRect(context, CGRectMake(_minX, _minY, self.rectSize.width, self.rectSize.height));
    CGContextStrokePath(context);
    
    // 绘制中间区域的四个角落
    CGFloat cornerLineLength = 9.0f;
    CGFloat cornerLineThick = 1.0f;
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, cornerLineThick);
    
    // 左上角
    CGContextMoveToPoint(context, _minX + cornerLineLength - cornerLineThick, _minY - cornerLineThick);
    CGContextAddLineToPoint(context, _minX - cornerLineThick, _minY - cornerLineThick);
    CGContextAddLineToPoint(context, _minX - cornerLineThick, _minY + cornerLineLength - cornerLineThick);
    
    CGContextMoveToPoint(context, _minX + cornerLineLength - cornerLineThick, _maxY + cornerLineThick);
    CGContextAddLineToPoint(context, _minX - cornerLineThick, _maxY + cornerLineThick);
    CGContextAddLineToPoint(context, _minX - cornerLineThick, _maxY + cornerLineThick - cornerLineLength);
    
    CGContextMoveToPoint(context, _maxX - cornerLineLength + cornerLineThick, _minY - cornerLineThick);
    CGContextAddLineToPoint(context, _maxX + cornerLineThick, _minY - cornerLineThick);
    CGContextAddLineToPoint(context, _maxX + cornerLineThick, _minY + cornerLineThick + cornerLineLength);
    
    CGContextMoveToPoint(context, _maxX - cornerLineLength + cornerLineThick, _maxY + cornerLineThick);
    CGContextAddLineToPoint(context, _maxX + cornerLineThick, _maxY + cornerLineThick);
    CGContextAddLineToPoint(context, _maxX + cornerLineThick, _maxY + cornerLineThick - cornerLineLength);
    
    CGContextStrokePath(context);
    
    
    
    
}

- (UIImageView *)animationLine {
    if (_animationLine == nil) {
        
        _animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(_minX, _minY, self.rectSize.width, 1.0f)];
        _animationLine.image = [UIImage imageNamed:@"scanner-line"];
        [self addSubview:_animationLine];
    }
    return _animationLine;
}

- (void)startAnimation {
    if (self.isAnimating) {
        return;
    }
    self.animating = YES;
    
    [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.animationReverse) {
            self.animationLine.frame = CGRectMake(_minX, _minY, self.rectSize.width, 1.0f);

        } else {
            self.animationLine.frame = CGRectMake(_minX, _maxY, self.rectSize.width, 1.0f);

        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.animationReverse = !self.animationReverse;
            self.animating = NO;
            [self startAnimation];
            
        } else {
            [self stopAnimation];
            
        }
    }];
}

- (void)stopAnimation {
    self.animating = NO;
    self.animationReverse = NO;
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    
    
}

@end
