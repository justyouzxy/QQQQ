//
//  UserCenterViewController.m
//  notice1
//
//  Created by 佳达 on 16/1/12.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"

@interface UserCenterViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *sectionTitleArr;
@property (nonatomic,strong) NSMutableArray *sectionImageArr;
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation UserCenterViewController

- (NSArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@"修改资料",@"我的人脉",@"收藏",@"相册",@"礼品商店",@"设置"];
    }
    return _sectionTitleArr;
}

- (NSMutableArray *)sectionImageArr {
    if (!_sectionImageArr) {
        _sectionImageArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"iconfont-shouye"],[UIImage imageNamed:@"iconfont-shouye"],
                                                                  [UIImage imageNamed:@"iconfont-shouye"],[UIImage imageNamed:@"iconfont-shouye"],
                                                                  [UIImage imageNamed:@"iconfont-shouye"],[UIImage imageNamed:@"iconfont-shouye"],nil];
    }
    return _sectionImageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:ScreeFrame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-tianjia"] style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    
    self.navigationItem.rightBarButtonItem = item;
    self.title = @"个人中心";
}

- (void)click {

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.sectionTitleArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        [self initSegment:cell];
    }else {
        cell.textLabel.text = self.sectionTitleArr[indexPath.row];
        cell.imageView.image = self.sectionImageArr[indexPath.row];
        cell.accessoryType = 1;
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"跳转下个页面 %ld",(long)indexPath);
    NSLog(@"%ld",(long)indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.hidesBottomBarWhenPushed = YES;
    UserInfoViewController *userInfo = [UserInfoViewController new];
    [self.navigationController pushViewController:userInfo animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        headerView.backgroundColor = RGB(158, 212, 242);
        
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 80, 80)];
        headImageView.center = headerView.center;
        UILabel *userLB = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 40, headerView.frame.size.height/2 + Default, 80, 20)];
//        headImageView.center = headerView.center;
        headImageView.image = [UIImage imageNamed:@"zhanweitu.jpg"];
        headImageView.layer.cornerRadius = 40;
        headImageView.layer.masksToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        userLB.text = @"测试数据";
        userLB.textAlignment = NSTextAlignmentCenter;
        userLB.font = [UIFont systemFontOfSize:15];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToLogin)];
        [headImageView addGestureRecognizer:tap];
        
        [headerView addSubview:headImageView];
        [headerView addSubview:userLB];
        return headerView;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 150 : 0;
}

-(void)tapToLogin
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:NO];
}

- (void)initSegment:(UITableViewCell *)cell {
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"进行中",@"已完成",@"已关闭"]];
    self.segment.frame = CGRectMake(0, 0, ScreenWidth, cell.contentView.frame.size.height);
//    self.segment.center = cell.contentView.center;
    
    self.segment.backgroundColor = WhiteColor;
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [cell.contentView addSubview:self.segment];
}
- (void)segmentValueChanged:(UISegmentedControl *)segment {
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            //self.view.backgroundColor = OrangeColor;
//            [self.tableView reloadData];
            break;
        case 1:
            //self.view.backgroundColor = RedColor;
//            [self.tableView reloadData];
            break;
        case 2:
            //self.view.backgroundColor = RedColor;
//            [self.tableView reloadData];
            break;
        default:
            break;
    }
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
