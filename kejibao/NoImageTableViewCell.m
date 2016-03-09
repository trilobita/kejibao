//
//  NoImageTableViewCell.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "NoImageTableViewCell.h"

@implementation NoImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellView];
        [self cellLayout];
    }
    
    return self;
}

+(NoImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView {
    NoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NEWLISTCELL"];
    
    //    if (!cell) {
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoImageTableViewCell" owner:nil options:nil] lastObject];
    //    }
    if (!cell) {
        cell = [[NoImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NEWLISTCELL"];
    }
    
    cell.titleLabel.text = model.title;
    cell.MediaNameLabel.text = model.media_name;
    cell.updataTimeLable.text = model.update_time;
    cell.clicksLabel.text = model.clicks;
    
    return cell;
}

/*
 titleLabel;
 MediaNameLabel;
 updataTimeLable;
 clicksLabel;
 eyeImageView;
 */
- (void)createCellView {
    
    //构建标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20*HVAR)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [self addSubview:_titleLabel];
    
    //构建媒体label
    _MediaNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*HVAR, 70*WVAR, 20*HVAR)];
    _MediaNameLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _MediaNameLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_MediaNameLabel];
    
    //构建更新时间label
    _updataTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(110*WVAR, 50*HVAR, 70*WVAR, 20*HVAR)];
    _updataTimeLable.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _updataTimeLable.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_updataTimeLable];
    
    //构建点击量label
    _clicksLabel = [[UILabel alloc] initWithFrame:CGRectMake(336*WVAR, 50*HVAR, 55*WVAR, 20*HVAR)];
    _clicksLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _clicksLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_clicksLabel];
    
    //构建点击量图标
    _eyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye_hide"]];
    _eyeImageView.contentMode = UIViewContentModeScaleToFill;
    _eyeImageView.clipsToBounds = YES;
    _eyeImageView.frame = CGRectMake(312*WVAR, 58*HVAR, 15*WVAR, 5*HVAR);
    [self addSubview:_eyeImageView];
    
}
- (void)cellLayout {
    
    float dis = 10.0f;
    
    //标题控件布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(dis);
        make.height.mas_equalTo(20);
    }];
    
    //媒体控件布局
    [_MediaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.mas_equalTo(_titleLabel);
        make.bottom.mas_equalTo(-dis);
        make.width.mas_equalTo(55);
    }];
    
    //时间控件布局
    [_updataTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.equalTo(_MediaNameLabel);
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(_MediaNameLabel.mas_right).offset(dis);
    }];
    
    //点击量控件布局
    [_clicksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.equalTo(_MediaNameLabel);
        make.right.mas_equalTo(-dis);
        make.width.mas_equalTo(55);
    }];
    
    //点击量图标布局
    [_eyeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_clicksLabel.mas_left).offset(-dis);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(15);
        make.bottom.equalTo(_clicksLabel.mas_bottom).offset(-6);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
