//
//  SubscribeTableViewCell.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SubscribeTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation SubscribeTableViewCell

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
+ (SubscribeTableViewCell *)setCellByModel:(SubscribeModel *)model tableView:(UITableView *)tableView {
    
    SubscribeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SUBSCRIBECELL"];
    
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubscribeTableViewCell" owner:self options:nil] lastObject];
//    }
    if (!cell) {
        cell = [[SubscribeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SUBSCRIBECELL"];
    }
    
    cell.tempModel = model;
    
    [cell.logo setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.titleLabel.text = model.title;
    cell.sloganLabel.text = model.slogan;
    
    return cell;
    
}
/*
 @property (weak, nonatomic) IBOutlet UIButton *addButton;
 @property (weak, nonatomic) IBOutlet UILabel *sloganLabel;
 @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *logo;
 */
- (void)createCellView {
    //构建添加按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"no_order"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    //构建logo控件
    _logo = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_logo];
    
    //构建标题控件
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:_titleLabel];
    
    //构建描述控件
    _sloganLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:_sloganLabel];
    
}
- (void) cellLayout {
    //logo控件布局
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.width.height.mas_equalTo(70);
        make.bottom.mas_equalTo(-5);
    }];
    
    //添加按钮布局
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(35);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    //标题控件布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logo.mas_right).offset(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(_addButton.mas_left).offset(-10);
        make.height.mas_equalTo(29);
    }];
    
    //描述控件布局
    [_sloganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(_titleLabel);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)clickAddButton:(UIButton *)button {
    
    SubscribeManger *manger = [SubscribeManger defineSubscribeManger];
    if (self.isAdd) {
        [manger.selectedSubscribeArray addObject:_tempModel];
        [manger.topicSubscribeArray removeObject:_tempModel];
        [manger.mediaSubscribeArray removeObject:_tempModel];
        
    } else {
        //如果移除的是最后一个并且已经被算中的操作方式
        if ( (manger.index) == [manger.selectedSubscribeArray indexOfObject:_tempModel] ) {
            manger.index--;
        }
        
        [manger.selectedSubscribeArray removeObject:_tempModel];
        
        if (_tempModel.subscribe_id) {
            [manger.topicSubscribeArray addObject:_tempModel];
        } else {
            [manger.mediaSubscribeArray addObject:_tempModel];
        }
    }
    
    NSString *dataPath = [NSString stringWithFormat:@"%@/titleList", TITLE_PATH];
    [NSKeyedArchiver archiveRootObject:manger.selectedSubscribeArray toFile:dataPath];
    
    [(UITableView *)self.superview.superview reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
