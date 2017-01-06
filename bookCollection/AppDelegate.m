//
//  AppDelegate.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "AppDelegate.h"
#import "BookListViewController.h"
#import "BookScannerViewController.h"
#import "BookAnalyticsViewController.h"

#import "BookBaseNavigationController.h"

#import "BookDBHelper.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDB];
    
    [self initWithTabbar];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - initDB 

- (void)initDB {
    // 检查数据库
    NSString *dbPath = [BookDBHelper dbPath];
    
    BOOL dbExist = [[NSFileManager defaultManager] fileExistsAtPath:dbPath isDirectory:nil];
    
    if (!dbExist) {
        [BookDBHelper buildDataBase];
    }
    
#ifdef DEBUG
    NSLog(@"dbpath: %@", dbPath);
#endif

}


#pragma mark - TabBar

- (void)initWithTabbar {

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    
    tabBarController.tabBar.barTintColor =[UIColor
                                           colorWithRed:255/255.0
                                           green:245/255.0
                                           blue:245/255.0
                                           alpha:1];
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:157/255.0 blue:130/255.0 alpha:1];
    
    BookListViewController *bookListController = [[BookListViewController alloc] init];
    BookBaseNavigationController *bookListNav = [[BookBaseNavigationController alloc] initWithRootViewController:bookListController];
    
    bookListController.tabBarItem.title = @"我的藏书";
    bookListController.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-collection"];
    
    BookScannerViewController *bookScannerController = [[BookScannerViewController alloc] init];
    bookScannerController.tabBarItem.title = @"扫描藏书";
    bookScannerController.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-scan"];
    
    BookAnalyticsViewController *bookAnalyticsController = [[BookAnalyticsViewController alloc] init];
    BookBaseNavigationController *bookAnalyticsNav= [[BookBaseNavigationController alloc] initWithRootViewController:bookAnalyticsController];
    
    bookAnalyticsController.tabBarItem.title = @"我";
    bookAnalyticsController.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-me"];
    
    
    self.window.rootViewController = tabBarController;
    
    tabBarController.viewControllers = @[bookListNav, bookScannerController, bookAnalyticsNav];
    
    tabBarController.tabBar.itemPositioning = UITabBarItemPositioningCentered;

}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    // 重写第二个TabBar的点击行为
    if ([viewController isKindOfClass:[BookScannerViewController class]]) {
        
        BookScannerViewController *bookScannerController = [[BookScannerViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:bookScannerController];
        [self.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
        return NO;
        // 点击第二个tabbar
    }
    
    return YES;
}



@end
