//
//  UserInfoViewController.m
//  notice1
//
//  Created by 佳达 on 16/1/13.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray* textLBArr;
@property (nonatomic,strong) NSArray* detailLBArr;

@end

@implementation UserInfoViewController

- (NSArray *)textLBArr {
    if (!_textLBArr) {
        _textLBArr = @[@"我的头像",@"用户ID",@"我的名字",@"我的年龄",@"公司单位",@"我的简介",@"我的微博"];
    }
    return _textLBArr;
}
- (NSArray *)detailLBArr {
    if (!_detailLBArr) {
        _detailLBArr = @[@"",@"00000",@"UserName",@"100岁",@"",@"",@"未开启",];
    }
    return _detailLBArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"我的资料";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textLBArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (indexPath.row == 1) {
        cell.accessoryType = 0;
    }else{
        cell.accessoryType = 1;
    }
    if (indexPath.row == 0) {
        UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 5, 40, 40)];
        headerImage.image = [UIImage imageNamed:@"zhanweitu.jpg"];
        [cell.contentView addSubview:headerImage];
    }
    
    cell.textLabel.text = self.textLBArr[indexPath.row];
    cell.detailTextLabel.text = self.detailLBArr[indexPath.row];
    
    return cell;
}

#pragma make - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
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
