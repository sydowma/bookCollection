//
//  BookWeakDisplayLink.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookWeakDisplayLink.h"
#import <UIKit/UIKit.h>

@interface BookWeakDisplayLink ()

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation BookWeakDisplayLink

- (void)start {
    if (_link == nil) {
        // CADisplayLink添加到Runloop
        _link = [CADisplayLink displayLinkWithTarget:self
                                            selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop]
                    forMode:NSRunLoopCommonModes];
    }
}

- (void)stop {
    [_link invalidate];
}

- (NSTimeInterval)timestamp {
    return (NSTimeInterval)[_link timestamp];
}

- (void)tick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(tick:)]) {
        [_delegate tick:self];
    }
}




@end
