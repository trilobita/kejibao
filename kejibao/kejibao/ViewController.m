//
//  ViewController.m
//  kejibao
//
//  Created by Trilobita on 16/2/22.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "ViewController.h"

#import "SubscribeViewController.h"
#import "SearchViewController.h"
#import "NewsListTableViewController.h"


@interface ViewController () <GUITabPagerDelegate, GUITabPagerDataSource>

@end

@implementation ViewController
{
    UIBarButtonItem *_menuBarButtonItem;
    UIBarButtonItem *_searchBarButtonItem;
    UIBarButtonItem *_subscribeBarButtonItem;
    SubscribeManger *_manger;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setBarBackgroundImage];
    if (_manger.index) {
        [self selectTabbarIndex:_manger.index animation:YES];
    }
    [self reloadData];
    [self selectTabbarIndex:_manger.index animation:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNavigation];
    
    self.delegate = self;
    self.dataSource = self;
    
    _manger = [SubscribeManger defineSubscribeManger];
    
    [self initTitleDataArr];
    
    
}

- (void)initTitleDataArr {
    NSString *dataPath = [NSString stringWithFormat:@"%@/titleList", TITLE_PATH];
    
    _manger.selectedSubscribeArray = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    if (!_manger.selectedSubscribeArray.count) {
        _manger.selectedSubscribeArray = [NSMutableArray array];
        SubscribeModel *model = [[SubscribeModel alloc] init];
        model.title = @"推荐";
        [_manger.selectedSubscribeArray addObject:model];
        [NSKeyedArchiver archiveRootObject:_manger.selectedSubscribeArray toFile:dataPath];
    }
}

//创建导航栏上的按钮
- (UIBarButtonItem *)createBarBUttonWithimageNamed:(NSString *)named action:(SEL)action{
    
    UIImage *image = [[Tool OriginImage:[UIImage imageNamed:named] scaleToSize:CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    
    return buttonItem;
}

//设置导航栏
- (void)settingNavigation {
    
    [self setBarBackgroundImage];
    
    //左菜单按钮
    _menuBarButtonItem = [self createBarBUttonWithimageNamed:@"menu_sign" action:@selector(clickMenuButton)];
    self.navigationItem.leftBarButtonItem = _menuBarButtonItem;
    
    //页标题
    UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-35.0f, 34.0f)];
    logo.text = @"科技报";
    logo.textColor = [UIColor whiteColor];
    logo.font = [UIFont boldSystemFontOfSize:25];
    self.navigationItem.titleView = logo;
    
    _searchBarButtonItem = [self createBarBUttonWithimageNamed:@"search" action:@selector(clickSearchButton)];
    _subscribeBarButtonItem = [self createBarBUttonWithimageNamed:@"subscribe" action:@selector(clickSubscriButton)];
    self.navigationItem.rightBarButtonItems = @[_subscribeBarButtonItem, _searchBarButtonItem];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44.0f)];
    imageView.image = [Tool OriginImage:[UIImage imageNamed:@"bg3"] scaleToSize:CGSizeMake(WIDTH, 44.0f)];
    [self.view addSubview:imageView];
    
}
#pragma mark <!--------barButton点击事件监听方法--------!>
//查询
- (void)clickSearchButton {
//    NSLog(@"查询");
    SearchViewController *svc = [[SearchViewController alloc] init];
    svc.url = @"article/search";
    [self.navigationController pushViewController:svc animated:YES];
}
//菜单
- (void)clickMenuButton {
    _showMenu();
}
//添加
- (void)clickSubscriButton {
//    NSLog(@"添加订阅");
    
    SubscribeViewController *svc = [[SubscribeViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
    
}

//设置bar的背景图片
- (void) setBarBackgroundImage {
    UINavigationBar *bar = self.navigationController.navigationBar;
    //无边界线
    [bar setBackgroundImage:[Tool OriginImage:[UIImage imageNamed:@"bg2"] scaleToSize:CGSizeMake(WIDTH, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    
}

#pragma mark <!--------代理方法--------!>
- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    
    NewsListTableViewController *newsListVc = [[NewsListTableViewController alloc] init];
    
    SubscribeModel *model = _manger.selectedSubscribeArray[index];
    
//    [model testModelPrint];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    if (model.subscribe_id) {
        [parameter setValue:model.subscribe_id forKey:@"topic_id"];
    }
    if (model.media_id) {
        [parameter setValue:model.media_id forKey:@"media_id"];
    }
    
    newsListVc.parameter = parameter;
    newsListVc.url = @"/article/index";
    
    return newsListVc;
}


- (NSInteger)numberOfViewControllers {
    return _manger.selectedSubscribeArray.count;
}
- (NSString *)titleForTabAtIndex:(NSInteger)index {
    SubscribeModel *model = _manger.selectedSubscribeArray[index];
    return model.title;
//    return _rowTitleDataArr[index];
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

- (void)tabPager:(GUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    _manger.index = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
