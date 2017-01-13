//
//  BookScannerViewController.m
//  bookCollection
//
//  Created by MAMIAN on 2017/1/3.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookScanView.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVMetadataObject.h>

#import <AFNetworking.h>

#import "BookEntity.h"
#import "BookDetailViewController.h"
#import "BookDetailService.h"

@interface BookScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) BookScanView *scanView;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) UIActivityIndicatorView *scanLoadingTipsView;

@property (nonatomic, strong) UILabel *scanLoadingTipsLabel;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self initNavigation];
    [self initSubviews];
    
//    [self scanLoadingTips];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
}

- (void)applicationFinishedRestoringState {
    
}


#pragma mark - Navigation

- (void)initNavigation {
    // 生成一个全透明的导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 去掉线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    
    [backButton addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    // 开关手电筒
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashButton sizeToFit];
    
    [flashButton addTarget:self action:@selector(didTapFlashButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashButton];
    
    
}

// 不显示状态栏的颜色1
- (BOOL)shouldShowShadowImage {
    return NO;
    
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage new];
}
/*  */


- (void)didTapBackButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapFlashButton:(UIButton *)button {
    button.selected = !button.selected;
}

#pragma mark - Subviews

- (void)initSubviews {
    [self initCamera];
    [self initScannerView];
    [self initTip];
}

- (void)initCamera {
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession beginConfiguration];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 输入UniFi Security Gateway
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error == nil) {
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
            
        }
    } else {
        NSLog(@"Input error = %@", error);
    }
    
    // 输出
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    if ([self.captureSession canAddOutput:captureOutput]) {
        [self.captureSession addOutput:captureOutput];
        captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
    }
    
    
    // 添加预览画面
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    layer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:layer];
    
    [self.captureSession commitConfiguration];
    
    [self.captureSession startRunning];
}

- (void)initScannerView {
    self.scanView = [[BookScanView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:CGSizeMake(230.0f, 230.0f) offsetY:-43.0f];
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scanView];
    
    [self.scanView startAnimation];
}

- (void)initTip {
    
}

#pragma mark - ISBN 识别

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    

    
    NSString *ISBN = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        ISBN = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        break;
    }
    
    if (ISBN != nil) {
        NSLog(@"ISBN = %@", ISBN);
        
        [self.captureSession stopRunning];
        [self.scanView stopAnimation];
        
        
        [self scanLoadingTips];
        
        
        
        [self fetchBookWithISBN:ISBN];
        
        
        
        
        
        
    }
}

- (void)fetchBookWithISBN:(NSString *)ISBN {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration
                                                defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:[NSString
                                       stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",
                                       ISBN]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self scanLoadingTips];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [self scanLoadingTips];
        [self.scanLoadingTipsView startAnimating];
        
        if (error != nil) {
            NSLog(@"Error = %@", error);
        } else {
            
            NSLog(@"%@, %@", response, responseObject);
            NSLog(@"thread = %@", [NSThread currentThread]);
            NSString *title = [responseObject objectForKey:@"title"];
            NSArray *authorList = [responseObject objectForKey:@"author"];
            NSString *author = nil;
            
            // 关闭UI提示
            [self.scanLoadingTipsView stopAnimating];
            self.scanLoadingTipsLabel.hidden = YES;
            
            
            if (authorList.count > 0) {
                author = [authorList firstObject];
            }
            
            BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"提示"
                                                  message:[NSString stringWithFormat:@"%@\n%@\n%@",
                                                           title, ISBN, author]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BookDetailViewController *controller = [[BookDetailViewController alloc] init];
                [controller setBookEntity:bookEntity];
                
                [self.navigationController pushViewController:controller animated:YES];
                }];
            
            [alertController addAction:detailAction];
            
            // 查看以前有没有收藏过
            BookEntity *favedBookEntity = [BookDetailService searchFavedBookWithDoubanId:bookEntity.doubanId];
            if (favedBookEntity == nil) {
                UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"收藏并继续扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.captureSession startRunning];
                    [self.scanView startAnimation];
                }];
                [alertController addAction:nextAction];
            }
            
            
            
            
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }];
    
    [dataTask resume];
    
    
}

#pragma mark - 扫描提示

- (void)scanLoadingTips {
    
//    self.scanLoadingTipsView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.scanView.minX + self.scanView.maxX / 2, self.scanView.minY + self.scanView.maxY / 2, 30, 30)];
    
    
    [self.scanLoadingTipsView startAnimating];
    
    
    
//    self.scanLoadingTipsLabel.center = CGPointMake(x, y + 20);
  
    self.scanLoadingTipsLabel.hidden = NO;
    
    
    
    
    
    
    
}

- (UIActivityIndicatorView *)scanLoadingTipsView {
    if (_scanLoadingTipsView == nil) {
        self.scanLoadingTipsView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.scanLoadingTipsView.hidesWhenStopped = YES;
        [self.view addSubview:self.scanLoadingTipsView];
        
        CGFloat x = self.scanView.minX + (self.scanView.maxX - self.scanView.minX) / 2;
        CGFloat y = self.scanView.minY + (self.scanView.maxY - self.scanView.minY) / 2;
        
        self.scanLoadingTipsView.center = CGPointMake(x, y);
    }
    return _scanLoadingTipsView;
}


/**
 失败

 @return <#return value description#>
 */
- (UILabel *)scanLoadingTipsLabel {
    if (_scanLoadingTipsLabel == nil) {
        self.scanLoadingTipsLabel = [[UILabel alloc] init];
        [self.view addSubview:self.scanLoadingTipsLabel];
        
        CGFloat x = self.scanView.minX + (self.scanView.maxX - self.scanView.minX) / 2;
        CGFloat y = self.scanView.minY + (self.scanView.maxY - self.scanView.minY) / 2;
        
        self.scanLoadingTipsLabel.frame = CGRectMake(x, y+20, 100, 30);
        self.scanLoadingTipsLabel.font = [UIFont systemFontOfSize:14];
        [self.scanLoadingTipsLabel sizeToFit];
        self.scanLoadingTipsLabel.textColor = [UIColor blackColor];
        self.scanLoadingTipsLabel.text = @"正在处理...";
    }
    return _scanLoadingTipsLabel;
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
