//
//  DemandViewController.m
//  laiyidian
//
//  Created by 佳达 on 16/1/18.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "InvitedViewController.h"

@interface InvitedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation InvitedViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60 + 2 * Pading, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应邀管理";
    [self initSegment];
    [self.view addSubview:self.tableView];
}
- (void)initSegment {
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"进行中",@"已完成",@"已关闭"]];
    self.segment.frame = CGRectMake(0, 60 ,ScreenWidth, 2 * Pading);
    
    self.segment.backgroundColor = WhiteColor;
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segment];
}
- (void)segmentValueChanged:(UISegmentedControl *)segment {
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            //self.view.backgroundColor = OrangeColor;
            [self.tableView reloadData];
            break;
        case 1:
            //self.view.backgroundColor = RedColor;
            [self.tableView reloadData];
            break;
        case 2:
            //self.view.backgroundColor = RedColor;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    //    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据 %u",arc4random() % 100];
    
    return cell;
}


@end
