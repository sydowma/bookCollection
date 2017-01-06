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

@property (nonatomic, assign) BookListMode mode;

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
    
    self.mode = BookListModeTableView;
    [self switchToMode:self.mode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    } else {
        BookListCollectionViewController *controller = [[BookListCollectionViewController alloc] init];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    }
}

@end
