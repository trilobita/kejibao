//
//  SubscribeTableViewController.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SubscribeTableViewController.h"
#import "SubscribeModel.h"
#import "SubscribeTableViewCell.h"
#import "detailedSubscribeViewController.h"

@interface SubscribeTableViewController ()

@end

@implementation SubscribeTableViewController
{
    NSString *_finalUrl;
    SubscribeManger *_manger;
    NSMutableArray *_dataArray;
    UIImageView *_noDataShowImage;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self emptyData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewStyle];
    
    _manger = [SubscribeManger defineSubscribeManger];
    
    if (_isAdd) {
        [self builFinalUrl];
        [self requestData];
    }
}

- (void)setTableViewStyle {
    
    [self.tableView setSeparatorColor:[UIColor grayColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
}

- (void)builFinalUrl {
    if (!_finalUrl) {
        _finalUrl = [NSString stringWithFormat:@"%@%@", SERVICE_URL, _url];
    }
}

- (void)requestData {
    
    NSDictionary *parameter = @{@"token":@"100c07a96d69681a093b5a3b988232ab"};
    NSLog(@"%@", _finalUrl);
    [NetWork newWorkPostWithURL:_finalUrl andParameter:parameter  contentType:@"text/html" toCache:YES complete:^(AFHTTPRequestOperation *operation, id responeObjc, NSError *error) {
        if (error) {
            NSLog(@"网络错误：%@", error);
            
        } else {
            
            _dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in responeObjc[@"data"]) {
                SubscribeModel *model = [[SubscribeModel alloc] init];
                [model setSubscribeModelByDictionary:dic];
                [_dataArray addObject:model];
            }
            
            if ([_url isEqualToString:@"media/index"]) {
                [_manger setMediaSubscribeArrayByArray:_dataArray];
            } else {
                [_manger setTopicSubscribeArrayByArray:_dataArray];
            }
            
            [self.tableView reloadData];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//订阅页面为空显示背景图片    半完成
- (void)emptyData {
    
    _noDataShowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    UIImage *image;
    
    if (_isAdd && !_dataArray.count) {
        if ([_url isEqualToString:@"media/index"]) {
            image = [UIImage imageNamed:@"over_media"];
        } else {
            image = [UIImage imageNamed:@"over_theme"];
        }
    } else if (!(_manger.selectedSubscribeArray.count-1) && !_isAdd) {
        image = [UIImage imageNamed:@"no_more_order"];
    } else {
        image = nil;
    }
    if (image) {
        [_noDataShowImage setImage:image];
        self.tableView.backgroundView = _noDataShowImage;
        self.tableView.scrollEnabled  = NO;
    } else {
        self.tableView.scrollEnabled =YES;
        self.tableView.backgroundView = nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isAdd) {
        if ([self.url isEqualToString:@"media/index"]) {
            return _manger.mediaSubscribeArray.count;
        } else {
            return _manger.topicSubscribeArray.count;
        }
    } else {
        return _manger.selectedSubscribeArray.count-1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SubscribeModel *model;
    if (_isAdd) {
        if ([self.url isEqualToString:@"media/index"]) {
            model = [_manger.mediaSubscribeArray objectAtIndex:indexPath.row];
        } else {
            model = [_manger.topicSubscribeArray objectAtIndex:indexPath.row];
        }
    } else {
        model = [_manger.selectedSubscribeArray objectAtIndex:indexPath.row+1];
    }
    
    SubscribeTableViewCell *cell = [SubscribeTableViewCell setCellByModel:model tableView:tableView];
    
    cell.isAdd = _isAdd;
    if (_isAdd) {
        [cell.addButton setBackgroundImage:[UIImage imageNamed:@"no_order"] forState:UIControlStateNormal];
    } else {
        [cell.addButton setBackgroundImage:[UIImage imageNamed:@"yes_oder"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    detailedSubscribeViewController *vc = [[detailedSubscribeViewController alloc] init];
    if (_isAdd) {
        if ([self.url isEqualToString:@"media/index"]) {
            vc.subscribeModel = _manger.mediaSubscribeArray[indexPath.row];
        } else {
            vc.subscribeModel = _manger.topicSubscribeArray[indexPath.row];
        }
    } else {
        vc.subscribeModel = _manger.selectedSubscribeArray[indexPath.row +1];
    }

    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
