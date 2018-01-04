//
//  XSViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2018/1/3.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSViewController.h"

@interface XSViewController ()

@end

@implementation XSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  配置导航栏
    [self configNav];
    
    //  配置UI
    [self configUI];
}

#pragma mark - pubilc

- (void)dismissToPresent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)popToPresent {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - rewrite
- (void)setTitle:(NSString *)title {
    super.title = title;
    self.navItem.title = title;
}

#pragma mark - config

- (void)configUI {
    self.contentView = [[UIView alloc] init];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
}

- (void)configNav {
    
    //  navBar
    self.navBar = [[UINavigationBar alloc] init];
    [self.navBar setTranslucent:NO];
    [self.navBar setTintColor:[UIColor darkGrayColor]];
    [self.navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}];
    
    //  navItem
    self.navItem = [[UINavigationItem alloc] initWithTitle:self.title];
    self.navBar.items = @[self.navItem];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToPresent)];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissToPresent)];
    
    if (self.presentingViewController != nil) {
        if (self.navigationController.childViewControllers.count > 1) {
            self.navItem.leftBarButtonItems = @[backItem, closeItem];
        } else {
            self.navItem.leftBarButtonItem = closeItem;
        }
    } else {
        if (self.navigationController.childViewControllers.count > 1) {
            self.navItem.leftBarButtonItem = backItem;
        }
    }
    
    //  添加到父视图
    [self.view addSubview:self.navBar];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBar_Height);
        make.left.right.offset(0);
        make.height.equalTo(@44);
    }];
}

@end
