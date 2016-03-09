//
//  CollectionTableViewCell.h
//  kejibao
//
//  Created by Trilobita on 16/3/4.
//  Copyright © 2016年 Triblobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collection+CoreDataProperties.h"
#import "NewsModel.h"

@interface CollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel    *titleLabel;
@property (nonatomic, strong) UILabel    *updateTimeLabel;
@property (nonatomic, strong) UILabel    *mediaNameLabel;
@property (nonatomic, strong) UILabel    *clicksLabel;
@property (nonatomic, strong) UIButton   *cancelButton;
@property (nonatomic, strong) Collection *Object;
@property (nonatomic, strong) NewsModel *temp;

@property (nonatomic, assign) BOOL       isCollection;

+ (CollectionTableViewCell *)setCellWithCollection:(Collection *)collection forTableView:(UITableView *)tableView;

@end
