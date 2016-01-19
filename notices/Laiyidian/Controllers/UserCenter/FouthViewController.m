//
//  FouthViewController.m
//  notice1
//
//  Created by mac on 16/1/6.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "FouthViewController.h"
#import "UserCenterViewController.h"

@interface FouthViewController ()

@end

@implementation FouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"4");
    self.title = @"聊天";
    
    [self createNavigationRightButton];
}

- (void)createNavigationRightButton {
    UIButton *userButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    userButton.backgroundColor = [UIColor clearColor];
    [userButton setImage:[UIImage imageNamed:@"iconfont-tianjia@2x"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(showUserCenter) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *userItem = [[UIBarButtonItem alloc]initWithCustomView:userButton];
    self.navigationItem.rightBarButtonItem = userItem;
}
- (void)showUserCenter {
    [self.navigationController pushViewController:[UserCenterViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
