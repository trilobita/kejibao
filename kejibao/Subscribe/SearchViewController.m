//
//  SearchViewController.m
//  kejibao
//
//  Created by Trilobita on 16/2/25.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    UITextField *_searchTextField;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setBarBackgroundImage];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self settingNavigation];
    [self buildSearchTextField];
    [self settingTableView];
    
    [self recoverKeyBoard];
    
}

- (void)buildSearchTextField {

    //文本框样式
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WIDTH-100, 34)];
    _searchTextField.placeholder = @"搜索热门文章";
    _searchTextField.borderStyle = 0;
    CGFloat size = _searchTextField.frame.size.height;
    //文本框左视图      放大镜图标
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(0, 0, size, size);
    [searchButton addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    _searchTextField.leftView = searchButton;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;

    //文本框右视图     ×图标
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 0, size, size);
    [closeButton setBackgroundImage:[UIImage imageNamed:@"search_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    _searchTextField.rightView = closeButton;
    _searchTextField.rightViewMode = UITextFieldViewModeAlways;
    
    [_searchTextField becomeFirstResponder];
    self.navigationItem.titleView = _searchTextField;
}

- (void)settingNavigation {
    
    UIImage *image = [[Tool OriginImage:[UIImage imageNamed:@"left_back"] scaleToSize:CGSizeMake(30.0f, 30.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButton;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingTableView {
    self.parameter = [[NSMutableDictionary alloc] init];
}

- (void) setBarBackgroundImage {
    UINavigationBar *bar = self.navigationController.navigationBar;
    //无边界线
    [bar setBackgroundImage:[Tool OriginImage:[UIImage imageNamed:@"maintab_bg"] scaleToSize:CGSizeMake(WIDTH, 74)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    
}

- (void)clickSearchButton:(UIButton *) button {
    
    [self.parameter setObject:_searchTextField.text forKey:@"keyword"];
    [_searchTextField resignFirstResponder];
    
    [self reloadDataAll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchTextField resignFirstResponder];
}

- (void)recoverKeyBoard {
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
}
- (void)commentTableViewTouchInSide{
    [_searchTextField resignFirstResponder];
}


@end
