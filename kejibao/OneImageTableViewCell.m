//
//  OneImageTableViewCell.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "OneImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation OneImageTableViewCell

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

+(OneImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView {
    OneImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ONENEWLISTCELL"];
    
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"OneImageTableViewCell" owner:nil options:nil] lastObject];
//    }
    if (!cell) {
        cell = [[OneImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ONENEWLISTCELL"];
    }
    
    cell.titleLabel.text = model.title;
    cell.mediaNameLabel.text = model.media_name;
    cell.updataLabel.text = model.update_time;
    cell.clicksLabel.text = model.clicks;
    
    [cell.urlImageview setImageWithURL:[NSURL URLWithString:model.main_image[0]]];
    
    return cell;
}

/*
urlImageview;
titleLabel;
eyeImageView;
clicksLabel;
mediaNameLabel;
updataLabel;
*/
- (void)createCellView {
    //构建标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250*WVAR, 55*HVAR)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    _titleLabel.numberOfLines = 2;
    [self addSubview:_titleLabel];
    
    //构建配图控件
    _urlImageview = [[UIImageView alloc] initWithFrame:CGRectMake(260*WVAR, 12*HVAR, 133*WVAR, 87*HVAR)];
    [self addSubview:_urlImageview];
    
    //构建媒体控件
    _mediaNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8*WVAR, 85*HVAR, 70*WVAR, 20*HVAR)];
    _mediaNameLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _mediaNameLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_mediaNameLabel];
    
    //构建更新时间控件
    _updataLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*WVAR, 85*HVAR, 70*WVAR, 20*HVAR)];
    _updataLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _updataLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_updataLabel];
    
    //构建点击量图标控件
    _eyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye_hide"]];
    _eyeImageView.contentMode = UIViewContentModeScaleToFill;
    _eyeImageView.clipsToBounds = YES;
    _eyeImageView.frame = CGRectMake(218*WVAR, 92*HVAR, 15*WVAR, 6*HVAR);
    [self addSubview:_eyeImageView];
    
    //构建点击量控件
    _clicksLabel = [[UILabel alloc] initWithFrame:CGRectMake(232*WVAR, 89*HVAR, 29*WVAR, 13*HVAR)];
    _clicksLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _clicksLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_clicksLabel];
    
}
- (void)cellLayout {
    
    float dis = 10.0f;
    
    //配图控件布局
    [_urlImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dis);
        make.right.bottom.mas_equalTo(-dis);
        make.width.mas_equalTo(133*WVAR);
    }];
    
    //标题控件布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(dis);
        make.height.mas_equalTo(55);
        make.right.mas_equalTo(_urlImageview.mas_left).offset(-dis);
    }];
    
    //媒体控件布局
    [_mediaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-dis);
        make.width.mas_equalTo(55);
    }];
    
    //时间控件布局
    [_updataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.equalTo(_mediaNameLabel);
        make.width.mas_equalTo(70);
        make.left.mas_equalTo(_mediaNameLabel.mas_right).offset(dis);
    }];
    
    //点击量控件布局
    [_clicksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.equalTo(_mediaNameLabel);
        make.right.mas_equalTo(_urlImageview.mas_left).offset(-5);
        make.width.mas_equalTo(20*WVAR);
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
