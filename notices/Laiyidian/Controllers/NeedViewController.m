//
//  NeedViewController.m
//  notice1
//
//  Created by mac on 16/1/13.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "NeedViewController.h"
#import "PGCategoryView.h"

@interface NeedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_leftTbale;
    UITableView *_rightTbale;
    UIView *_contentView;
    NSArray *_SectionArray;
    NSArray *_cellArray;
    NSInteger aaa;
}
@property (strong, nonatomic) PGCategoryView *categoryView;
@end

@implementation NeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//- (void)viewWillAppear:(BOOL)animated {
//    self.tabBarController.tabBar.hidden = YES;
//}
-(void)initData
{
    _SectionArray = @[@"休闲娱乐",@"运动健康",@"丽人时尚"];
    _cellArray = @[@"带跑步",@"享美食",@"连唱歌",@"看电影"];
    _cellArray = @[@[@"带跑步",@"享美食",@"连唱歌",@"看电影"],@[@"1",@"2",@"3"],@[@"5",@"6",@"7",@"8",@"9"]];
}
-(void)togogo
{
    NSLog(@"selector");
}

-(void)createView
{
//    _SectionArray = @[@"1",@"2",@"3",@"4",@"5"];
    UISegmentedControl *segement = [[UISegmentedControl alloc] initWithItems:nil];
    segement.segmentedControlStyle = UISegmentedControlStyleBar;
    [segement insertSegmentWithTitle:@"1" atIndex:0 animated:NO];
    [segement insertSegmentWithTitle:@"2" atIndex:1 animated:NO];
    self.navigationItem.titleView = segement;
    [segement addTarget:self action:@selector(togogo) forControlEvents:UIControlEventValueChanged];
    
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //    _contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_contentView];
    
    _leftTbale = [[UITableView alloc] init];
    _leftTbale.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    _leftTbale.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    _rightTbale = [[UITableView alloc] init];
    _rightTbale.frame = CGRectMake(0, 64, _contentView.bounds.size.width, _contentView.bounds.size.height);
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    _rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTbale) {
        return _SectionArray.count;
    }else{
        return _cellArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTbale) {
        
//        NSLog(@"!!!!!!!!!!!!!!!!!!!!");
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        //设置cell右边有箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        NSLog(@"%ld",(long)indexPath.section);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 100, 30)];
        label.text = [_SectionArray objectAtIndex:indexPath.row];
        label.textColor = RGBA(0, 0, 255, 0.3);
        [cell.contentView addSubview:label];
//        cell.backgroundColor = RGBA(120, 120, 120, 0.2);
        return cell;
    }else{
//        NSLog(@"222222222222222");
        static NSString *CellIdentifier2 = @"Cell2";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        
        //        cell.textLabel.text = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.row,(long)indexPath.section];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 60, 30)];
        if (aaa == 0) {
//            NSLog(@"%@",[_cellArray objectAtIndex:0]);
            label.text = [[_cellArray objectAtIndex:0] objectAtIndex:indexPath.row];
            [cell.contentView addSubview:label];
        }
        if (aaa == 1) {
//            NSLog(@"%@",[_cellArray objectAtIndex:aaa]);
            label.text = [[_cellArray objectAtIndex:aaa] objectAtIndex:indexPath.row];
            [cell.contentView addSubview:label];
        }
        if (aaa == 2) {
//            NSLog(@"%@",[_cellArray objectAtIndex:aaa]);
            label.text = [[_cellArray objectAtIndex:aaa] objectAtIndex:indexPath.row];
            [cell.contentView addSubview:label];
        }
        
     
        return cell;
    }
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _leftTbale) {
        [_categoryView show];
        aaa = indexPath.row;
        NSLog(@"%d",aaa);
        [_rightTbale reloadData];
    }
    else{
        NSLog(@"tap right tableview index:%ld",(long)indexPath.row);
       
        
    }
    
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
