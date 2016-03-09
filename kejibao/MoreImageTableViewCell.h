//
//  MoreImageTableViewCell.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface MoreImageTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *mediaNameLabel;
@property (strong, nonatomic) UILabel *updateTimeLabel;

@property (strong, nonatomic) UIImageView *eyeImageView;
@property (strong, nonatomic) UILabel *clicksLabel;
@property (strong, nonatomic) UIImageView *urlImage1;
@property (strong, nonatomic) UIImageView *urlImage2;
@property (strong, nonatomic) UIImageView *urlImage3;

+ (MoreImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView;

@end
