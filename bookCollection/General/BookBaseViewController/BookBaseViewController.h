//
//  BookViewController.h
//  bookCollection
//
//  Created by MAMIAN on 2017/1/4.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookBaseViewController : UIViewController

- (void)adjustNavigator;
- (BOOL)shouldHideBottomBarWhenPushed;
- (BOOL)shouldShowShadowImage;

@end
