//
//  SubscribeViewController.m
//  kejibao
//
//  Created by Trilobita on 16/2/25.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeTableViewController.h"

@interface SubscribeViewController () <GUITabPagerDelegate, GUITabPagerDataSource>

@end

@implementation SubscribeViewController
{
    NSArray *_titleArray;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setBarBackgroundImage];
    [self reloadData];
//    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
    _titleArray = @[@"所有主题", @"所有媒体", @"我的订阅"];
    
    [self settingNavigation];
}

- (void)settingNavigation {
    
    //左返回按钮
    UIImage *image = [[Tool OriginImage:[UIImage imageNamed:@"left_back"] scaleToSize:CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //页标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-35.0f, 34.0f)];
    titleLabel.text = @"订阅";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 25];
    self.navigationItem.titleView = titleLabel;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50.0f)];
    imageView.image = [Tool OriginImage:[UIImage imageNamed:@"maintab_bg"] scaleToSize:CGSizeMake(WIDTH, 50.0f)];
    [self.view addSubview:imageView];
    
}

//设置bar的背景图片
- (void) setBarBackgroundImage {
    UINavigationBar *bar = self.navigationController.navigationBar;
    //无边界线
    [bar setBackgroundImage:[Tool OriginImage:[UIImage imageNamed:@"maintab_bg"] scaleToSize:CGSizeMake(WIDTH, 74)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    
}

- (UIButton *)titleButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 75.0f, 30.0f);
    [button setTitle:@"订阅" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    
    return button;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <!--------协议方法--------!>
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    SubscribeTableViewController *stvc = [[SubscribeTableViewController alloc] init];
    
    stvc.isAdd = index == 2 ? NO : YES;
    
    if (index) {
        stvc.url = @"media/index";
    } else {
        stvc.url = @"topic/index";
    }
    
    return stvc;
}

-(NSInteger)numberOfViewControllers {
    
    return _titleArray.count;
}

- (NSString *)titleForTabAtIndex:(NSInteger)index {
    return _titleArray[index];
}
- (UIColor *)tabColor {
    return [UIColor whiteColor];
}
- (UIFont *)titleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
}
-(UIColor *)titleColor {
    return [UIColor whiteColor];
}

@end
