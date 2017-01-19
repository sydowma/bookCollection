//
//  BookAnalyticsViewController.m
//  StudyPrivateCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookAnalyticsViewController.h"
#import <Masonry/Masonry.h>

#import "BookListService.h"
#import "PieChartView.h"
#import "PieChartView+Author.h"
#import "BookAnalyticsTableViewCell.h"
#import "BookAnalyticsTableViewCell+Author.h"

@interface BookAnalyticsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) CGFloat sumAuthorCount;

@property (nonatomic, strong) UILabel *sumAuthorCountLabel;

@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntities;

@property (nonatomic, strong) NSMutableArray *authorArr;

@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;

@end

@implementation BookAnalyticsViewController

- (NSMutableArray<BookEntity *> *)bookEntites {
    
    if (!_bookEntities) {
        
        _bookEntities = [@[] mutableCopy];
        
    }
    
    return _bookEntities;
    
}

- (NSMutableArray *)authorArr {
    if (!_authorArr) {
        _authorArr = [@[] mutableCopy];
    }
    return _authorArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self shouldShowShadowImage];

    [self initSubviews];
    self.navigationItem.title = @"我的藏书";

    [self getDataWithOffset:0 pageSize:100];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.sumAuthorCount = 0;
    
    //     不是第一次加载
    if (self.isFirstLoad == NO) {
        //         无论有多少页，每次都取从第0 到当前收藏的
        //         这里count要加1（扫描的那个）
        // 这个逻辑判断还有问题 
        [self getDataWithOffset:0 pageSize:self.bookEntities.count+1];
    } else {
        // 在第一次加载之后将其改为NO
        self.firstLoad = NO;
        
    }


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)initNavigation {
    
}

- (BOOL)shouldShadowImage {
    return NO;
}

#pragma mark -- data




- (void)getDataWithOffset: (long long)offset pageSize: (NSInteger)pageSize {
    
    // 清除缓存
    if (offset == 0) {
        [self.bookEntities removeAllObjects];
        [self.authorArr removeAllObjects];
    }
    
    // 返回的是一个NSArray，我们将其返回一个可变类型的copy，也就是深复制
    [BookListService getBookEntityListWithOffset:0 size:100 completion:^(NSArray<BookEntity *> *bookEntities) {
        //        [self.bookEntities addObjectsFromArray:bookEntities];
        [self.bookEntities addObjectsFromArray:bookEntities];
        
        self.sumAuthorCount = self.bookEntities.count;
        
        for (BookEntity *entity in self.bookEntites) {
            //        self.sumAuthorCount += entity.authors.count;
            [self.authorArr addObject:entity.authors];
        }
        [self.tableView reloadData];
        _sumAuthorCountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.sumAuthorCount];
    }];
    
    

    
}

#pragma mark - initSubviews

- (void)initSubviews {
    
    _headerView = [UIView new];
    _headerView.backgroundColor = UIColorFromRGB(0x009D82);
    [self.view addSubview:_headerView];
    
    [_headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(280);
    }];
    
    PieChartView *view = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    view.backgroundColor = UIColorFromRGB(0x009D82);
    [view configureWithBookEntity:self.authorArr withRadius:100];
    
    [_headerView addSubview:view];
    
    
    _sumAuthorCountLabel = [UILabel new];
    _sumAuthorCountLabel.textColor = UIColorFromRGB(0x009D82);
    _sumAuthorCountLabel.font = [UIFont systemFontOfSize:30.0f];
    _sumAuthorCountLabel.textAlignment = NSTextAlignmentCenter;
    [_sumAuthorCountLabel sizeToFit];
    [_headerView addSubview:_sumAuthorCountLabel];

    [_sumAuthorCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100-40, 40));
        make.center.mas_equalTo(CGPointMake(_headerView.bounds.size.width/2, _headerView.bounds.size.height/2+64-20));
    }];
    
    _authorLabel = [UILabel new];
    _authorLabel.textColor = [UIColor lightGrayColor];
    _authorLabel.text = @"作者总数";
    _authorLabel.textAlignment = NSTextAlignmentCenter;
    _authorLabel.font = [UIFont systemFontOfSize:16.0f];
    [_authorLabel sizeToFit];
    
    [_headerView addSubview:_authorLabel];
    
    [_authorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*2, 40));
        make.center.mas_equalTo(CGPointMake(_headerView.bounds.size.width/2, _headerView.bounds.size.height/2+20));
    }];
    
//    _tableView = [UITableView new];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    //为了让tableView自适应高度设置如下两个属性
    tableView.estimatedRowHeight = 50;
    tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
    
}

#pragma mark -- UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.authorArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"bookAnalyticsTableViewCell";
    
    BookAnalyticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[BookAnalyticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (self.bookEntities.count > 0) {
        BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
        [cell configureWithBookEntity:entity];

    }
    
    
    return cell;
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 60;
//    
//}



@end
