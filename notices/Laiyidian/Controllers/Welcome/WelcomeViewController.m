//
//  WelcomeViewController.m
//  notice1
//
//  Created by 佳达 on 16/1/15.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "WelcomeViewController.h"

#import "XMTabBarController.h"
#import "HWPopTool.h"

#import "FistViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"

#import "DemandViewController.h"


@interface WelcomeViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) XMTabBarController *tabBar;

@property (nonatomic, strong) UIScrollView *welcomeScrollView;
@property (nonatomic, strong) NSMutableArray *imagesArr;

@end

@implementation WelcomeViewController

- (NSMutableArray *)imagesArr {
    if (!_imagesArr) {
        _imagesArr = [[NSMutableArray alloc] initWithObjects:
                      [UIImage imageNamed:@"welcome_1"],
                      [UIImage imageNamed:@"welcome_2"],
                      [UIImage imageNamed:@"welcome_3"],
                      [UIImage imageNamed:@"welcome_4"],nil];
    }
    return _imagesArr;
}

- (UIScrollView *)welcomeScrollView {
    if (!_welcomeScrollView) {
        _welcomeScrollView = [[UIScrollView alloc]initWithFrame:ScreeFrame];
        _welcomeScrollView.showsVerticalScrollIndicator = NO;
        _welcomeScrollView.showsHorizontalScrollIndicator = NO;
        _welcomeScrollView.pagingEnabled = YES;
        _welcomeScrollView.userInteractionEnabled = YES;
        _welcomeScrollView.bounces = NO;
        [_welcomeScrollView setContentSize:CGSizeMake(ScreenWidth * self.imagesArr.count, ScreenHeight)];
    }
    return _welcomeScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.welcomeScrollView];
    for (int i = 0 ; i < self.imagesArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imagesArr[i]];
        imageView.frame = CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [self.welcomeScrollView addSubview:imageView];
        if (i == self.imagesArr.count - 1) {
            [imageView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createTabBar:)];
            tap.numberOfTouchesRequired = 1;
            tap.numberOfTapsRequired = 1;
            [imageView addGestureRecognizer:tap];
        }
    }
}

- (void)createTabBar:(UITapGestureRecognizer *)tapGR{
    NSMutableArray * normalImage = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"iconfont-shouye"],[UIImage imageNamed:@"iconfont-first"],[UIImage imageNamed:@"iconfont-shoucang"],[UIImage imageNamed:@"iconfont-set"],nil];
    NSMutableArray * selectedImage = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"iconfont-shouye_press"],[UIImage imageNamed:@"iconfont-first_press"],[UIImage imageNamed:@"iconfont-shoucang_press"],[UIImage imageNamed:@"iconfont-set_press"],nil];
    NSMutableArray * titles = [[NSMutableArray alloc]initWithObjects:@"附近",@"需求管理",@"技能管理",@"消息", nil];
    
    FistViewController *vc1 = [FistViewController new];
    DemandViewController *vc2 = [DemandViewController new];
    ThirdViewController *vc3 = [ThirdViewController new];
    FouthViewController *vc4 = [FouthViewController new];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    self.tabBar = [[XMTabBarController alloc] initWithItemNormalImages:normalImage SelectedImages:selectedImage titles:titles];
    self.tabBar.showCenterItem = YES;
    self.tabBar.centerItemImage = [UIImage imageNamed:@"tianjia"];
    self.tabBar.viewControllers = @[nav1,nav2,nav3,nav4];
    self.tabBar.textColor = [UIColor orangeColor];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = self.tabBar;
}

@end
