//
//  BookListViewController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListTableViewController.h"
#import "BookListCollectionViewController.h"

typedef NS_ENUM(NSUInteger, BookListMode) {
    BookListModeTableView,
    BookListModeCollectionView
};

@interface BookListViewController ()

@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;

@property (nonatomic, assign) BookListMode mode;

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstLoad = YES;
    [self initNavigation];
    
    self.mode = BookListModeTableView;
    [self switchToMode:self.mode];
    
//    self.navigationController.navigationBar.translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 第一次结束后
    self.firstLoad = NO;

}


#pragma mark - Navigation

- (void)initNavigation {
    self.navigationItem.title = @"我的藏书";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list-switch-table"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSwitchButton:)];
    
}

- (void)didTapSwitchButton:(UIBarButtonItem *)barButtonItem {
    // 移除child controller
    [self.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:) withObject:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(didMoveToParentViewController:) withObject:nil];
    
    if (self.mode == BookListModeTableView) {
        
        // 平铺模式
        self.mode = BookListModeCollectionView;
        barButtonItem.image = [UIImage imageNamed:@"list-switch-table"];
    } else {
        self.mode = BookListModeTableView;
        barButtonItem.image = [UIImage imageNamed:@"list-switch-collection"];
    }
    
    [self switchToMode:self.mode];
}

- (void)switchToMode: (BookListMode)mode {
    // 添加child controller
    if (mode == BookListModeTableView) {
        BookListTableViewController *controller = [[BookListTableViewController alloc] init];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        
        // 这里暂时有个问题 UITableViewWrapperView 会出问题，
        // 第一次进入时显示正常，切换Mode后会往上偏移，实际上是没有根据Nav自动适应
        if (!self.isFirstLoad) {
            controller.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);

        } else {
            controller.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

        }
        
        [controller didMoveToParentViewController:self];
        
    } else {
        BookListCollectionViewController *controller = [[BookListCollectionViewController alloc] init];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        [controller didMoveToParentViewController:self];
    }
}

@end
