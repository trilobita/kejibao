//
//  NewsListTableViewController.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "NewsListTableViewController.h"
#import "NewsModel.h"
#import "NoImageTableViewCell.h"
#import "OneImageTableViewCell.h"
#import "MoreImageTableViewCell.h"
#import "NewsViewController.h"
#import "MBProgressHUD.h"

@interface NewsListTableViewController ()

@end

@implementation NewsListTableViewController
{
    NSString *_finalUrl;
    NSMutableArray *_dataArray;
    MBProgressHUD *_hud;
    BOOL toCache;
}

- (void)reloadDataAll {
    [_dataArray removeAllObjects];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self builFinalUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self builFinalUrl];
    
    _dataArray = [NSMutableArray array];
    _hud = [[MBProgressHUD alloc] init];
    _hud.center = self.view.center;
    _hud.labelText = @"数据加载中";
    [self.view addSubview:_hud];
    _hud.color = [UIColor colorWithRed:0.68 green:0.94 blue:1 alpha:1];
    _hud.square = YES;
    toCache = YES;
    [self requestData];
    
    [self setLoadingAndRefresh];
}

//加载刷新
- (void)setLoadingAndRefresh {
    __weak UITableView *tempTableView = self.tableView;
    
    //下拉刷新
    [self.tableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tempTableView headerEndRefreshing];
        });
    }];
    
    //上拉加载
    [self.tableView addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tempTableView footerEndRefreshing];
        });
        
    }];
}

//刷新数据方法

//加载数据方法


- (void)builFinalUrl {
    if (!_finalUrl) {
        _finalUrl = [NSString stringWithFormat:@"%@%@", SERVICE_URL, _url];
    }
}

- (void)requestData {
    
    [_parameter setValue:@"100c07a96d69681a093b5a3b988232ab" forKey:@"token"];
    [_hud show:YES];
    
     [NetWork newWorkPostWithURL:_finalUrl andParameter:_parameter contentType:@"text/html" toCache:toCache complete:^(AFHTTPRequestOperation *operation, id responeObjc, NSError *error) {
        if (error) {
            NSLog(@"网络错误：%@", error);
            _hud.labelText = @"网络错误!";
            [_hud hide:YES afterDelay:5];
        } else {
            for (NSDictionary *dic in responeObjc[@"data"]) {
                NewsModel *model = [[NewsModel alloc] init];
                [model setNewsModelByDictionary:dic];
//                [model testToPrintModel];
                [_dataArray addObject:model];
            }
            
            [self.tableView reloadData];
            _hud.labelText = @"加载完成!";
            _hud.square = NO;
            _hud.mode = MBProgressHUDModeText;
            [_hud hide:YES afterDelay:2];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return nil;
    NewsModel *tempModel = _dataArray[indexPath.row];
//    NSLog(@"title:%@    imageNum%@",tempModel.title, tempModel.image_num);

    if (tempModel.main_image.count == 0) {
        return [NoImageTableViewCell setCellByModel:tempModel tableView:tableView];
    }
    else if (tempModel.main_image.count < 3) {
        return [OneImageTableViewCell setCellByModel:tempModel tableView:tableView];
    }
    else {
        return [MoreImageTableViewCell setCellByModel:tempModel tableView:tableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *tempModel = _dataArray[indexPath.row];

    if (tempModel.main_image.count == 0) {
        return 80.0f;
    }
    else if (tempModel.main_image.count < 3) {
        return 110.0f;
    }
    else {
        return 170.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsViewController *nvc = [[NewsViewController alloc] init];
    nvc.news = _dataArray[indexPath.row];
    [self.navigationController pushViewController:nvc animated:YES];
}

@end
