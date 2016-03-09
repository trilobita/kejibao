//
//  NewsViewController.m
//  kejibao
//
//  Created by Trilobita on 16/3/1.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "NewsViewController.h"
#import "DataBaseManager.h"

#define BOTTOM_HEIGHT 40

@interface NewsViewController () <UIWebViewDelegate>

@end

@implementation NewsViewController
{
    NSString *_finalUrl;
    UIView *_bottomView;
    UIButton *_shareButton;
    UIButton *_collectBUtton;
    UIButton *_praiseButton;
    UITextField *_discussTextField;
    UIButton *_backButton;
    BOOL _isCollect;
    
    DataBaseManager *_manager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)settingStatus {
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    
    statusBarView.backgroundColor=[UIColor colorWithRed:0.16 green:0.56 blue:0.89 alpha:1];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [DataBaseManager SingletonPattern];
    
    [self builderFinnlUrl];
    
    [self builderWebView];
    
    [self builderBottomView];
    [self bottomViewLayout];
    
    [self settingStatus];
}

- (void)builderWebView {
    
    UIWebView *showNewsWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-BOTTOM_HEIGHT)];
    
    showNewsWebView.delegate = self;
    
    showNewsWebView.backgroundColor = [UIColor whiteColor];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_finalUrl]];
    [showNewsWebView loadRequest:request];
    [self.view addSubview:showNewsWebView];
}

- (void)builderFinnlUrl {
    _finalUrl = [NSString stringWithFormat:@"%@index/article_v2?news_id=%@&token=100c07a96d69681a093b5a3b988232ab", SERVICE_URL, self.news.news_id];
    

}

- (void)builderBottomView {
    
    //实例化底视图区
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-BOTTOM_HEIGHT, WIDTH, BOTTOM_HEIGHT)];
//    bottomView.backgroundColor = [UIColor greenColor];
    _bottomView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIImageView *backGroundImage = [[UIImageView alloc] initWithImage:[Tool OriginImage:[UIImage imageNamed:@"newsdetail_bg"] scaleToSize:CGSizeMake(WIDTH, 55)]];
    [_bottomView addSubview:backGroundImage];
    [self.view addSubview:_bottomView];
    
    //实例化返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(10, 10, 35, 35);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_backButton];
//    _backButton.backgroundColor = [UIColor redColor];
    
    //实例化吐槽输入框
    _discussTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 10, 70, 35)];
//    _discussTextField.borderStyle = UITextBorderStyleLine;
    [_discussTextField setBackground:[Tool OriginImage:[UIImage imageNamed:@"edit_noclik"] scaleToSize:CGSizeMake(70, 35)]];
    [_bottomView addSubview:_discussTextField];
    
    //实例化点赞按钮
    _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _praiseButton.frame = CGRectMake(215, 10, 35, 35);
    [_praiseButton setImage:[UIImage imageNamed:@"no_zan"] forState:UIControlStateNormal];
    [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_praiseButton];
//    _praiseButton.backgroundColor = [UIColor yellowColor];
    
    //实例化收藏按钮
    _collectBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBUtton.frame = CGRectMake(255, 10, 35, 35);
    if ([_manager selectObjectWithNewsModel:self.news].count) {
        _isCollect = YES;
    } else {
        _isCollect = NO;
    }
    [self setCollectButtonBackImage];
    [_collectBUtton addTarget:self action:@selector(clickCollectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_collectBUtton];
//    _collectBUtton.backgroundColor = [UIColor greenColor];
    
    //实例化分享按钮
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.frame = CGRectMake(295, 10, 35, 35);
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_shareButton];
//    _shareButton.backgroundColor = [UIColor blueColor];
    
}
-(void)setCollectButtonBackImage {
    if (_isCollect) {
        [_collectBUtton setBackgroundImage:[UIImage imageNamed:@"mycollection_press"] forState:UIControlStateNormal];
    } else {
        [_collectBUtton setBackgroundImage:[UIImage imageNamed:@"mycollection"] forState:UIControlStateNormal];
    }
}
//返回、点赞、收藏、分享按钮事件监听
- (void)back:(UIButton *)button {
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickPraiseButton:(UIButton *)button {
    NSLog(@"点赞");
    [_praiseButton setImage:[UIImage imageNamed:@"yes_zan"] forState:UIControlStateNormal];
}
- (void)clickCollectButton:(UIButton *)button {
    NSLog(@"收藏");
    if (_isCollect) {
        [_manager deleteObjectWithNewsModel:self.news];
    } else {
        [_manager insertObjectWithNewsModel:self.news];
    }
    _isCollect = !_isCollect;
    [self setCollectButtonBackImage];
}
- (void)clickShareButton:(UIButton *)button {
    NSLog(@"分享");

}

//底部视图布局
- (void)bottomViewLayout {
    
    CGSize size = _bottomView.frame.size;
    CGFloat dis = 5;
//    NSLog(@"%f", size.height);
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(size.height-2*dis-5);
        make.left.top.mas_equalTo(dis+5);
        make.bottom.mas_equalTo(-dis);
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.bottom.top.mas_equalTo(_backButton);
        make.right.mas_equalTo(-15);
    }];
    [_collectBUtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.bottom.top.mas_equalTo(_backButton);
        make.right.mas_equalTo(_shareButton.mas_left).offset(-15);
    }];
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.width.top.mas_equalTo(_backButton);
        make.right.mas_equalTo(_collectBUtton.mas_left).offset(-15);
    }];
    [_discussTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.top.mas_equalTo(_backButton);
        make.left.mas_equalTo(_backButton.mas_right).offset(dis);
//        make.right.mas_equalTo(_praiseButton.mas_left).offset(-dis);
        make.width.mas_equalTo(150);
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        NSLog(@"url%@", url);
        
        if([[UIApplication sharedApplication]canOpenURL:url])
        {
            [[UIApplication sharedApplication]openURL:url];
        }
        return NO;
    }
    return YES;
}

#pragma mark <!--------判断新闻所属主题是否被订阅--------!>

#pragma mark <!--------点击了页面中的订阅按钮--------!>
- (void) clickHTMLPageButton {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
