//
//  MenuViewController.m
//  kejibao
//
//  Created by Trilobita on 16/3/3.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "MenuViewController.h"
#import "DataBaseManager.h"
#import "CollectionTableViewCell.h"
#import "NewsViewController.h"
#import "YRSideViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController
{
    UIView *_headerView;
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    DataBaseManager *_databaseManager;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self selectDataForDatabase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self buildHeaderViewAndTableView];
    [self viewLayout];

    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    _databaseManager = [DataBaseManager SingletonPattern];
}

- (void)buildHeaderViewAndTableView {
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"maintab_bg"]];
    [self.view addSubview:_headerView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_iconImageView setImage:[UIImage imageNamed:@"mycollection"]];
    [_headerView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.text = @"我的收藏";
    [_headerView addSubview:_titleLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH*LEFTVIEWSCALE, HEIGHT-64)];
    [self.view addSubview:_tableView];
//test
//    _tableView.backgroundColor = [UIColor yellowColor];
}
- (void)viewLayout {
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH*LEFTVIEWSCALE);
        make.height.mas_equalTo(64);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerView.mas_bottom).offset(-0);
        make.width.mas_equalTo(WIDTH*LEFTVIEWSCALE);
        make.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HEIGHT-64);
    }];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(22);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(_iconImageView);
    }];
}

//查找本地存储数据
- (void)selectDataForDatabase {
    _dataArray = [NSMutableArray arrayWithArray:[_databaseManager selectAllObjectFromDataBase]];
    [_tableView reloadData];
}


#pragma mark <!--------tableView代理方法--------!>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CollectionTableViewCell setCellWithCollection:_dataArray[indexPath.row] forTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsViewController *newVC = [[NewsViewController alloc] init];
    newVC.news = [Tool collectionToNewsModelWith:_dataArray[indexPath.row]];
    YRSideViewController *tempVc = (id)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [tempVc hideSideViewController:YES];
    UINavigationController *rootvc = (id)tempVc.rootViewController;
    [rootvc pushViewController:newVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
