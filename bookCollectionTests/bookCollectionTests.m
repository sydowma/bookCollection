//
//  bookCollectionTests.m
//  bookCollectionTests
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BookDBHelper.h"
#import "BookDetailService.h"
#import "BookAuthor.h"
#import "BookTag.h"
#import "BookTranslator.h"
#import "BookListService.h"
#import <AFNetworking/AFNetworking.h>

@interface bookCollectionTests : XCTestCase

@property (nonatomic, strong) BookEntity *mockEntity;

@end

@implementation bookCollectionTests

// 每一段测试代码在执行之前都会执行   初始化
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [BookDBHelper resetDataBase];
}

// 每一段测试代码执行之后执行   销毁工作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (BookEntity *)mockEntity {
    if (_mockEntity == nil) {
        
        // 实体
        BookEntity *entity = [[BookEntity alloc] init];
        entity.doubanId = 7061934;
        entity.title = @"SQLite权威指南";
        entity.isbn10 = @"7121149249";
        entity.isbn13 = @"9787121149245";
        entity.image = @"https://img3.douban.io.com/lpic/s7043073.jpg";
        entity.publisher = @"电子工业出版社";
        entity.pubdate = @"2012-1-15";
        entity.price = @"69.00元";
        
        // 作者
        BookAuthor *author1 = [[BookAuthor alloc] init];
        author1.name = @"Grant Allen";
        
        BookAuthor *author2 = [[BookAuthor alloc] init];
        author2.name  = @"Mike Owens";
        
        // 标签
        BookTag *tag1 = [[BookTag alloc] init];
        tag1.name = @"SQLite";
        
        BookTag *tag2 = [[BookTag alloc] init];
        tag2.name = @"计算机";
        
        entity.tags = @[tag1, tag2];
        
        //译者
        BookTranslator *translator1 = [[BookTranslator alloc] init];
        translator1.name = @"杨谦";
        
        BookTranslator *translator2 = [[BookTranslator alloc] init];
        translator2.name = @"刘义宣";
        
        BookTranslator *translator3 = [[BookTranslator alloc] init];
        translator3.name = @"谢志强";
        
        entity.translators = @[translator1, translator2, translator3];
        
        _mockEntity = entity;
        
        }
    return _mockEntity;
}

- (void)testFavBook {
    
    BOOL success = [BookDetailService favBook:self.mockEntity];
    
    XCTAssert(success, "Fav book result should be success");
    
    BookEntity *entity = [BookDetailService searchFavedBookWithDoubanId:self.mockEntity.doubanId];
    XCTAssertNotNil(entity, @"Faved book should not be nil when searched by doubanId");
    
}

- (void)testUnFavBook {
    [self measureBlock:^{
        [BookDetailService searchFavedBookWithDoubanId:self.mockEntity.doubanId];
    }];
}

- (void)testNetworkAPI {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString
                                       stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",
                                       self.mockEntity.isbn13]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [expectation fulfill];
        
        XCTAssertNotNil(responseObject, @"responseObject should not be nil");
        XCTAssertNil(error, "error should be nil");
        
        BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
        XCTAssertNotNil(bookEntity, @"bookEntity should not be nil");
    }];
    
    [dataTask resume];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        [dataTask cancel];
    }];
    
}

// 测试代码块
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
