//
//  BookScanView.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookScanView : UIView

@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxY;

- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY;

- (void)startAnimation;
- (void)stopAnimation;

@end
