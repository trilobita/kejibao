//
//  MoreImageTableViewCell.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "MoreImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MoreImageTableViewCell

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

+(MoreImageTableViewCell *)setCellByModel:(NewsModel *)model tableView:(UITableView *)tableView {
    MoreImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MORENEWLISTCELL"];
    
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreImageTableViewCell" owner:nil options:nil] lastObject];
//    }
    if (!cell) {
        cell = [[MoreImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MORENEWLISTCELL"];
    }
    
    cell.titleLabel.text = model.title;
    cell.mediaNameLabel.text = model.media_name;
    cell.updateTimeLabel.text = model.update_time;
    cell.clicksLabel.text = model.clicks;

    [cell.urlImage1 setImageWithURL:[NSURL URLWithString:model.main_image[0]]];
    [cell.urlImage2 setImageWithURL:[NSURL URLWithString:model.main_image[1]]];
    [cell.urlImage3 setImageWithURL:[NSURL URLWithString:model.main_image[2]]];
    
    return cell;
}

/*
 @property (strong, nonatomic) UILabel *titleLabel;
 @property (strong, nonatomic) UILabel *mediaNameLabel;
 @property (strong, nonatomic) UILabel *updateTimeLabel;
 
 @property (strong, nonatomic) UIImageView *eyeImageView;
 @property (strong, nonatomic) UILabel *clicksLabel;
 @property (strong, nonatomic) UIImageView *urlImage1;
 @property (strong, nonatomic) UIImageView *urlImage2;
 @property (strong, nonatomic) UIImageView *urlImage3;
 */
- (void)createCellView {
    //构建标题控件
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:_titleLabel];
    
    //构建媒体控件
    _mediaNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _mediaNameLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _mediaNameLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_mediaNameLabel];
    
    //构建跟新时间控件
    _updateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _updateTimeLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _updateTimeLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_updateTimeLabel];
    
    //构建点击量图标控件
    _eyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye_hide"]];
    _eyeImageView.contentMode = UIViewContentModeScaleToFill;
    _eyeImageView.clipsToBounds = YES;
    _eyeImageView.frame = CGRectMake(218*WVAR, 92*HVAR, 15*WVAR, 6*HVAR);
    [self addSubview:_eyeImageView];
    
    //构建点击量控件
    _clicksLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    _clicksLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    _clicksLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:_clicksLabel];
    
    //构建配图控件
    _urlImage1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_urlImage1];
    
    _urlImage2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_urlImage2];
    
    _urlImage3 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_urlImage3];

}
- (void)cellLayout {
    
    float dis = 10.0f;
    
    //标题布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(dis);
        make.right.mas_equalTo(-dis);
        make.height.mas_equalTo(20);
    }];
    //媒体控件布局
    [_mediaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dis);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(dis);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    //更新时间控件布局
    [_updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_mediaNameLabel);
        make.left.mas_equalTo(_mediaNameLabel.mas_right).offset(-dis);
    }];
    //点击量控件布局
    [_clicksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-dis);
        make.height.top.mas_equalTo(_mediaNameLabel);
        make.width.mas_equalTo(20);
    }];
    //点击量图标布局
    [_eyeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_clicksLabel.mas_left).offset(-dis);
        make.height.mas_equalTo(6);
        make.width.mas_equalTo(15);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(dis+7);
    }];
    //配图控件布局
    [_urlImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mediaNameLabel.mas_bottom).offset(dis);
        make.left.mas_equalTo(dis);
        make.bottom.mas_equalTo(-dis);
        make.width.mas_equalTo((WIDTH-dis*4)/3);
    }];
    [_urlImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-dis);
        make.top.width.mas_equalTo(_urlImage1);
    }];
    [_urlImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(_urlImage1);
        make.left.mas_equalTo(_urlImage1.mas_right).offset(dis);
        make.right.mas_equalTo(_urlImage3.mas_left).offset(-dis);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
