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

#import "BookDetailService.h"
#import "BookDetailViewController.h"

#import "BookFPSLabel.h"
#import <SVPullToRefresh.h>

static NSInteger defaultPageSize = 100;

@interface BookListTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntities;

@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;

@end

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ViewDidLoad: %f", CFAbsoluteTimeGetCurrent());
    self.view.backgroundColor = [UIColor redColor];
    self.firstLoad = YES;
    
    [self initTableView];
    [self getDataWithOffset:0 pageSize:defaultPageSize];
    
    // 直接创建
    self.bookEntities = [@[] mutableCopy];
    
    [self showFPSLabel];
}




/**
 选择在每次回到这个控制器的时候都去刷新数据，另一种方案是在扫描到书籍时候发送一个Notification

 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 第一次进入会调用两次（ViewDidLoad、ViewDidAppera）， 需要解决
    
//     不是第一次加载
    if (self.isFirstLoad == NO) {
//         无论有多少页，每次都取从第0 到当前收藏的
//         这里count要加1（扫描的那个）
        [self getDataWithOffset:0 pageSize:self.bookEntities.count+1];
    } else {
        // 在第一次加载之后将其改为NO
        self.firstLoad = NO;

    }
    
//    [self getDataWithOffset:0 pageSize:defaultPageSize];
    
}

// 没有成功显示
- (void)showFPSLabel {
    BookFPSLabel *label = [[BookFPSLabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
}

#pragma mark - data 

- (void)getDataWithOffset: (long long)offset pageSize: (NSInteger)pageSize {
    
    // 清除缓存
    if (offset == 0) {
        [self.bookEntities removeAllObjects];
    }
    
    // 返回的是一个NSArray，我们将其返回一个可变类型的copy，也就是深复制
    [BookListService getBookEntityListWithOffset:offset size:pageSize completion:^(NSArray<BookEntity *> *bookEntities) {
        [self.bookEntities addObjectsFromArray:bookEntities];
        [self.tableView reloadData];
    }];
    
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
    
//    [tableView addInfiniteScrollingWithActionHandler:^{
//        // TBD 及时获取到上一页的数据
//    }];
    
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
    
    if (!cell.coverImageView.image) {
        // 判断图片是否在拖动或滚动中
        if (tableView.dragging == NO && tableView.decelerating == NO) {
            [cell startDownloadCoverImageWithBookEntity:entity];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
        BOOL success = [BookDetailService unFavBookWithId:entity.id];
        // 删除动画
        if (success) {
            [tableView beginUpdates];
            // 数据源和UI要保持一致
            [self.bookEntities removeObject:entity];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BookEntity *bookEntity = [self.bookEntities objectAtIndex:indexPath.row];
    [self goToBookDetailPage: bookEntity];
    
}

#pragma mark - ScrollView Delegate

// 确保当前的UItableView没有滚动或拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadCoverImageForVisibleCells];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadCoverImageForVisibleCells];
}

// 只取出当前页面内可见的Cell， 对可见的Cell进行加载和渲染
- (void)loadCoverImageForVisibleCells {
    NSArray<BookListTableViewCell *> *visibleCells = [self.tableView visibleCells];
    for (BookListTableViewCell *cell in visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        BookEntity *bookEntity = [self.bookEntities objectAtIndex:indexPath.row];
        
        if (!cell.coverImageView.image) {
            [cell startDownloadCoverImageWithBookEntity:bookEntity];
        }
    }
}

#pragma mark - Navigation Protocol

- (void)goToBookDetailPage: (BookEntity *)entity {
    BookDetailViewController *controller = [[BookDetailViewController alloc] init];
    [controller setBookEntity:entity];
    [self.navigationController pushViewController:controller animated:YES];
}




@end
