//
//  NewsListTableViewController.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewController : UITableViewController

@property (nonatomic, strong) NSString            *url;
@property (nonatomic, strong) NSMutableDictionary *parameter;

- (void)reloadDataAll;

@end
