//
//  SubscribeTableViewCell.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeModel.h"

@interface SubscribeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UILabel *sloganLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *logo;
@property (nonatomic, strong) SubscribeModel *tempModel;
@property (nonatomic, assign) BOOL isAdd;

//- (void)clickButton:(UIButton *)button;

+ (SubscribeTableViewCell *)setCellByModel:(SubscribeModel *)model tableView:(UITableView *)tableView;

@end
