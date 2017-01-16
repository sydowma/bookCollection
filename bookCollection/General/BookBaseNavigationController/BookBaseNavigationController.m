//
//  BookNavigationController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/4.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookBaseNavigationController.h"
#import "BookBaseViewController.h"

@interface BookBaseNavigationController ()

@end

@implementation BookBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x009D82)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果是Nav push后就隐藏底部TabBar
    if ([viewController isKindOfClass:[BookBaseViewController class]]) {
        ((BookBaseViewController *)viewController).hidesBottomBarWhenPushed = [(BookBaseViewController *) viewController shouldHideBottomBarWhenPushed];
    } else {
        
    }
    [super pushViewController:viewController animated:animated];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
