//
//  BookListCollectionViewController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/6.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookListCollectionViewController.h"
#import "BookListCollectionViewCell.h"
#import "BookEntity.h"
#import "BookListCollectionViewCell+BookEntity.h"
#import "BookDetailViewController.h"
#import "BookListService.h"


@interface BookListCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntities;

@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;

@end

static NSString *identifier = @"bookListCollectionViewCell";

@implementation BookListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 直接创建
    self.bookEntities = [@[] mutableCopy];
    
    [self initCollectionView];
    [self getDataWithOffset:0 pageSize:100];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;// 默认是YES
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));

}

- (void)initCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 这里为了不使整体上移 所以加了64
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[BookListCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    self.collectionView = collectionView;
    
 
    
    
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
        [self.collectionView reloadData];
    }];
    
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bookEntities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BookListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    
    [cell configureWithBookEntity:entity];
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BookEntity *bookEntity = [self.bookEntities objectAtIndex:indexPath.row];
    [self goToBookDetailPage:bookEntity];
}

#pragma mark - Navigation Protocol

- (void)goToBookDetailPage: (BookEntity *)entity {
    BookDetailViewController *controller = [[BookDetailViewController alloc] init];
    [controller setBookEntity:entity];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - item Size


// 每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

// 每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.bounds.size.width - 2 * 15 - 2 * 20) / 3;
    
    /**
     cell的高度
     20 --> 文字高度
     15 --> 上面间隔
     64 --> 整体偏移的高度
     */
    CGFloat height = (self.view.bounds.size.height - 1 * 15 - 2 * 20 - 64) / 3;
    return CGSizeMake(width, height);
}

#pragma mark - ScrollView Delegate

// 确保当前的UItableView没有滚动或拖动  有复用问题 没有使用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
//        [self loadCoverImageForVisibleCells];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self loadCoverImageForVisibleCells];
}

// 只取出当前页面内可见的Cell， 对可见的Cell进行加载和渲染
- (void)loadCoverImageForVisibleCells {
    NSArray<BookListCollectionViewCell *> *visibleCells = [self.collectionView visibleCells];
    for (BookListCollectionViewCell *cell in visibleCells) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        BookEntity *bookEntity = [self.bookEntities objectAtIndex:indexPath.row];
        
        if (!cell.coverImageView.image) {
            [cell startDownloadCoverImageWithBookEntity:bookEntity];
        }
    }
}




@end
