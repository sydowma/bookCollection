//
//  BookViewController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/4.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseViewController.h"

@interface BookBaseViewController ()

@end

@implementation BookBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    // 解决整体上移问题
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustNavigator];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - navigation config

- (void)adjustNavigator {
    //是否隐藏导航底部的线
    if ([self shouldShowShadowImage]) {
        [self.navigationController.navigationBar setShadowImage:nil];
    } else {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 是否使用自定义的背景（透明）
    if ([self navigationBarBackgroundImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
        
    } else {
        self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x009D82);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (UIImage *)navigationBarBackgroundImage {
    return nil;
}

- (BOOL)shouldShowShadowImage {
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed {
    return NO;
}




@end
