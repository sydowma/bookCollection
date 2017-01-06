//
//  BookListTableViewController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListTableViewController.h"
#import "BookListService.h"
#import "BookBaseTableViewCell.h"

#import "BookListTableViewCell.h"
#import "BookListTableViewCell+BookEntity.h"

@interface BookListTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntities;

@end

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
    [self getData];
    
}


/**
 选择在每次回到这个控制器的时候都去刷新数据，另一种方案是在扫描到书籍时候发送一个Notification

 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 第一次进入会调用两次（ViewDidLoad、ViewDidAppera）， 需要解决
    [self getData];
}

#pragma mark - data 

- (void)getData {
    // 返回的是一个NSArray，我们将其返回一个可变类型的copy，也就是深复制
    self.bookEntities = [[BookListService getAllBookEntities] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - subview

- (void)initTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    // 宽度高度自适应
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookEntities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"bookListTableViewCell";
    
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    
    [cell configureWithBookEntity:entity];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end
