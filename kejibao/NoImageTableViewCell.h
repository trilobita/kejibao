//
//  NoImageTableViewCell.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NoImageTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *MediaNameLabel;
@property (strong, nonatomic) UILabel     *updataTimeLable;
@property (strong, nonatomic) UILabel     *clicksLabel;
@property (strong, nonatomic) UIImageView *eyeImageView;

+ (NoImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView;

@end
