//
//  BookWeakDisplayLink.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookWeakDisplayLinkDelegate <NSObject>

- (void)tick:(id)sender;

@end

@interface BookWeakDisplayLink : NSObject



- (void)stop;
- (void)start;
- (NSTimeInterval)timestamp;

@property (nonatomic, weak) id <BookWeakDisplayLinkDelegate>delegate;

@end
