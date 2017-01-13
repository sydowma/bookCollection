//
//  BookFPSLabel.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookFPSLabel.h"
#import "BookWeakDisplayLink.h"

@interface BookFPSLabel () <BookWeakDisplayLinkDelegate>

@property (nonatomic, strong) BookWeakDisplayLink *link;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;

@end

@implementation BookFPSLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [_link stop];
}

- (void)setup {
    _link = [[BookWeakDisplayLink alloc] init];
    _link.delegate = self;
    
    
//    self.textColor = [UIColor blackColor]; 
    self.text = @"fps 0";
    [_link start];
}

- (void)tick:(BookWeakDisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        
        NSLog(@"First Tick: %f", CFAbsoluteTimeGetCurrent());
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    
    if (delta >= 1) {
        
        _lastTime = link.timestamp;
        double fps = _count / delta;
        _count = 0;
        
        self.text = [NSString stringWithFormat:@"fps %d", (int)fps];
    }
}





@end
