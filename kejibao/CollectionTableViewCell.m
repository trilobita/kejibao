//
//  CollectionTableViewCell.m
//  kejibao
//
//  Created by Trilobita on 16/3/4.
//  Copyright © 2016年 Triblobita. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "DataBaseManager.h"

@implementation CollectionTableViewCell
{
    UIImageView *_clicksIconImageView;
//    NewsModel *_temp;
//    BOOL _isCollection;
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createControls];
        [self controlsLayout];
        _isCollection = YES;
    }
    return self;
}

+ (CollectionTableViewCell *)setCellWithCollection:(Collection *)collection forTableView:(UITableView *)tableView {
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COLLECTIONCELL"];
    
    if (!cell) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"COLLECTIONCELL"];
    }
    
    cell.titleLabel.text      = collection.title;
    cell.mediaNameLabel.text  = collection.media_name;
    cell.updateTimeLabel.text = collection.update_time;
    cell.clicksLabel.text     = collection.clicks;
    cell.Object = collection;
    [cell.cancelButton setBackgroundImage:[UIImage imageNamed:@"yes_collect"] forState:UIControlStateNormal];
    cell.isCollection = YES;
    if (cell.temp) {
        cell.temp = nil;
    }
    return cell;
}

- (void)createControls {
    _titleLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [self addSubview:_titleLabel];
    
    _mediaNameLabel           = [[UILabel alloc] initWithFrame:CGRectZero];
    _mediaNameLabel.font      = [UIFont systemFontOfSize:11.0f];
    _mediaNameLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [self addSubview:_mediaNameLabel];
    
    _updateTimeLabel           = [[UILabel alloc] initWithFrame:CGRectZero];
    _updateTimeLabel.font      = [UIFont systemFontOfSize:11.0f];
    _updateTimeLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [self addSubview: _updateTimeLabel];
    
    _clicksLabel           = [[UILabel alloc] initWithFrame:CGRectZero];
    _clicksLabel.font      = [UIFont systemFontOfSize:11.0f];
    _clicksLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [self addSubview:_clicksLabel];
    
    _clicksIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye_hide"]];
    [self addSubview:_clicksIconImageView];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"yes_collect"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
}
- (void)controlsLayout {
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(_cancelButton.mas_left).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [_mediaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        //        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(90);
    }];
    
    [_updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.mas_equalTo(_mediaNameLabel);
        make.left.mas_equalTo(_mediaNameLabel.mas_right).offset(5);
    }];
    
    [_clicksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(_mediaNameLabel);
        make.right.mas_equalTo(_cancelButton.mas_left).offset(-5);
        make.width.mas_equalTo(20);
    }];
    
    [_clicksIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(15);
        make.right.mas_equalTo(_clicksLabel.mas_left).offset(-5);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(8.5f);
    }];
    
}
- (void)clickButton:(UIButton *)button {
//test
//    NSLog(@"删除");
    DataBaseManager *manager = [DataBaseManager SingletonPattern];
    NSLog(@"3--->%@", _Object.title);
    if (_isCollection) {
        if (!_temp) {
            [self willDeleteObject];
            [manager deleteObjectWithCollectionObject:_Object];
        } else {
            [manager deleteObjectWithNewsModel:_temp];
        }
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"no_collect"] forState:UIControlStateNormal];
    } else {
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"yes_collect"] forState:UIControlStateNormal];
        [manager insertObjectWithNewsModel:_temp];
        
        NSLog(@"2--->%@", _temp.title);
    }
    _isCollection = !_isCollection;
}

- (void)willDeleteObject {
    NSLog(@"1-->%@", _temp.title);
    _temp = [Tool collectionToNewsModelWith:_Object];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
