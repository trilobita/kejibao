//
//  detailedSubscribeViewController.m
//  kejibao
//
//  Created by Trilobita on 16/3/3.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "detailedSubscribeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SubscribeTableViewController.h"
#import "NewsModel.h"

#import "NoImageTableViewCell.h"
#import "OneImageTableViewCell.h"
#import "MoreImageTableViewCell.h"
#import "NewsViewController.h"

#import "MBProgressHUD.h"

@interface detailedSubscribeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation detailedSubscribeViewController
{
    UIView *_subscribeView;
    UIImageView *_logoImageView;
    UILabel *_titleLable;
    UILabel *_slogan;
    UIButton *_addSubscribeButton;
    SubscribeManger *_manger;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manger = [SubscribeManger defineSubscribeManger];
    _dataArray = [NSMutableArray array];
    
    [self createSubscribeView];
    [self createTableView];
    [self subscribeViewLayout];
    
    [self setData];
    [self settingNavigation];
    [self requestData];
}
- (void)settingNavigation {
    
    //左返回按钮
    UIImage *image = [[Tool OriginImage:[UIImage imageNamed:@"left_back"] scaleToSize:CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //页标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-35.0f, 34.0f)];
    titleLabel.text = _subscribeModel.title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 20];
    self.navigationItem.titleView = titleLabel;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50.0f)];
    imageView.image = [Tool OriginImage:[UIImage imageNamed:@"maintab_bg"] scaleToSize:CGSizeMake(WIDTH, 50.0f)];
    [self.view addSubview:imageView];
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setData {
    [_logoImageView setImageWithURL:[NSURL URLWithString:_subscribeModel.logo]];
    _titleLable.text = _subscribeModel.title;
    _slogan.text = _subscribeModel.slogan;
}

- (void)createSubscribeView {

    _subscribeView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 50.0f)];
//test
    _subscribeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_subscribeView];
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//test
//    [_logoImageView setImage:[UIImage imageNamed:@"activity"]];
    [_subscribeView addSubview:_logoImageView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
//test
//    _titleLable.text = @"测试";
    [_subscribeView addSubview:_titleLable];
    
    _slogan = [[UILabel alloc] initWithFrame:CGRectZero];
//test
//    _slogan.text = @"测试数据";
    _slogan.font = [UIFont systemFontOfSize:12];
    [_subscribeView addSubview:_slogan];
    
    _addSubscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addSubscribeButton.titleLabel.font = [UIFont systemFontOfSize:11];
    
    [_addSubscribeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if ([self isAlready]) {
        [_addSubscribeButton setBackgroundColor:[UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1]];

        [_addSubscribeButton setTitle:@"已订阅" forState:UIControlStateNormal];
    } else {
        
        [_addSubscribeButton setBackgroundColor:[UIColor colorWithRed:1 green:0.77 blue:0 alpha:1]];

        [_addSubscribeButton setTitle:@"+ 订阅" forState:UIControlStateNormal];
    }
    [_addSubscribeButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [_subscribeView addSubview:_addSubscribeButton];
}
- (void)clickAddButton:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"+ 订阅"]) {
        [_addSubscribeButton setBackgroundColor:[UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1]];
        
        [_addSubscribeButton setTitle:@"已订阅" forState:UIControlStateNormal];
        [_manger.selectedSubscribeArray addObject:_subscribeModel];
        [_manger.mediaSubscribeArray removeObject:_subscribeModel];
        [_manger.topicSubscribeArray removeObject:_subscribeModel];
    }
}
- (BOOL)isAlready {
    
    for (SubscribeModel *model in _manger.selectedSubscribeArray) {
        if ([model.title isEqualToString:_subscribeModel.title]) {
            return YES;
        }
    }
    return NO;
}
- (void)subscribeViewLayout {

    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.height.mas_equalTo(40);
    }];
    [_addSubscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(50);
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImageView.mas_right).offset(5);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(_addSubscribeButton.mas_left).offset(-5);
    }];
    [_slogan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLable);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(_titleLable.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-10);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_subscribeView.mas_bottom).offset(0);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (void)requestData {
    
    NSString *url = [NSString stringWithFormat:@"http://api.wankeji.com.cn/article/index"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@"100c07a96d69681a093b5a3b988232ab" forKey:@"token"];
    if (_subscribeModel.media_id) {
        [parameter setObject:_subscribeModel.media_id forKey:@"media_id"];
    } else {
        [parameter setObject:_subscribeModel.subscribe_id forKey:@"topic_id"];
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.center = self.view.center;
    hud.color = [UIColor colorWithRed:0.68 green:0.94 blue:1 alpha:1];
    hud.labelText = @"正在捕抓最新资讯";
    hud.square = YES;
    [hud show:YES];
    
    [NetWork newWorkPostWithURL:url andParameter:parameter  contentType:@"text/html" toCache:YES complete:^(AFHTTPRequestOperation *operation, id responeObjc, NSError *error) {
        if (error) {
            NSLog(@"网络出错：%@", error);
            hud.mode = MBProgressHUDModeText;
            hud.square = NO;
            hud.labelText = @"网络连接出错!";
            [hud hide:YES afterDelay:4];
        } else {
            for (NSDictionary *dic in responeObjc[@"data"]) {
                NewsModel *model = [[NewsModel alloc] init];
                [model setNewsModelByDictionary:dic];
//                                [model testToPrintModel];
                [_dataArray addObject:model];
            }
            hud.mode = MBProgressHUDModeText;
            hud.square = NO;
            hud.labelText = @"成功捕抓到数条新资讯";
            [hud hide:YES afterDelay:2];
            [_tableView reloadData];
        }
    }];
    
}

#pragma mark <!--------协议方法--------!>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"最新新闻";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
