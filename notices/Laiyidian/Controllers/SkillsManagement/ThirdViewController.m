//
//  ThirdViewController.m
//  notice1
//
//  Created by mac on 16/1/6.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "ThirdViewController.h"

#import "InvitedViewController.h"
#import "SkillViewController.h"
#import "VerifyViewController.h"

//#import "ViewController.h"

@interface ThirdViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView* tableView;
@end

@implementation ThirdViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"技能管理";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        [self addButtons:cell];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 40;
}

#pragma mark - MyMethod
- (void)addButtons:(UITableViewCell *)cell {
    UIButton *invitedButton = [Factory createBUttonWithTitle:@"我的应邀" frame:CGRectMake(0, 0, self.view.frame.size.width / 3,100) backgroudImage:@"zhanweitu.jpg" target:self selector:@selector(show1)];
    UIButton *button2 = [Factory createBUttonWithTitle:@"我的技能" frame:CGRectMake(self.view.frame.size.width / 3, 0, self.view.frame.size.width / 3, 100) backgroudImage:@"zhanweitu.jpg" target:self selector:@selector(show2)];
    UIButton *button3 = [Factory createBUttonWithTitle:@"个人认证" frame:CGRectMake(self.view.frame.size.width / 3 * 2, 0, self.view.frame.size.width / 3, 100) backgroudImage:@"zhanweitu.jpg" target:self selector:@selector(show3)];
    
    [cell.contentView addSubview:invitedButton];
    [cell.contentView addSubview:button2];
    [cell.contentView addSubview:button3];
}
- (void)show1{
    NSLog(@"1");
    [self.navigationController pushViewController:[InvitedViewController new] animated:YES];
}
- (void)show2{
    NSLog(@"2");
    [self.navigationController pushViewController:[SkillViewController new] animated:YES];
}
- (void)show3{
    NSLog(@"3");
    [self.navigationController pushViewController:[VerifyViewController new] animated:YES];
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
