//
//  OneImageTableViewCell.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface OneImageTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *urlImageview;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *eyeImageView;
@property (strong, nonatomic) UILabel *clicksLabel;
@property (strong, nonatomic) UILabel *mediaNameLabel;
@property (strong, nonatomic) UILabel *updataLabel;

+ (OneImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView;

@end
