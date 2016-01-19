//
//  SkillsDetailsViewController.m
//  laiyidian
//
//  Created by 佳达 on 16/1/19.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "SkillsDetailsViewController.h"

@interface SkillsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SkillsDetailsViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4 + Default, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self initHeadView];
    [self initSegment];
}

- (void)initHeadView {
    UIView *headView = [Factory createViewWithBackgroundColor:RGB(181, 239, 249) frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 4)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
    imageView.frame = CGRectMake(Default, Default, headView.frame.size.width / 2 - 2 * Default, headView.frame.size.width / 2 - 2 * Default);
    imageView.layer.cornerRadius = imageView.frame.size.width / 2 ;
    imageView.layer.masksToBounds = YES;
    [headView addSubview:imageView];
    [self.view addSubview:headView];
}
- (void)initSegment {
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"技能详情",@"主页",@"评价"]];
    segment.frame = CGRectMake(0, ScreenHeight / 4, ScreenWidth, Default);
    
    [self.view addSubview:segment];
}

#pragma mark -- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell'"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据 %u",arc4random() % 100];
    
    return cell;
}

@end
