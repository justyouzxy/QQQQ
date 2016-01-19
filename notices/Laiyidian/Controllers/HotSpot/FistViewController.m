//
//  FistViewController.m
//  notice1
//
//  Created by mac on 16/1/6.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "FistViewController.h"
#import "NewsScrollView.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "CustomViewController.h"


#import "YLSlideView.h"
#import "YLSlideConfig.h"
#import "YLSlideCell.h"

#import "ArrayData.h"
#import "SubjectManageViewController.h"

#import "DCPicScrollView.h"
#import "DCWebImageManager.h"

@interface FistViewController ()<YLSlideViewDelegate,UITableViewDataSource,UITableViewDelegate,PostSelectArray>
{
    FistViewController *_homeView;
    
    YLSlideView * _slideView;
    NSArray *_titleArray;
    NSArray *_testArray;
    
}

PropertyStrong(NewsScrollView, news);

@end

@implementation FistViewController

- (void)viewDidLoad {
    
//    self.view.backgroundColor = WhiteColor;
    
    [super viewDidLoad];
self.view.backgroundColor = WhiteColor;
    
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    if (self.selectedSubjectArray) {
        _titleArray = self.selectedSubjectArray;
    }
    else
    {
        _titleArray = [ArrayData defaultSelectedSubject];
    }
    
    //最上面手机状态栏的视图颜色
    UIView *view = [Factory createViewWithBackgroundColor:RGB(252, 90, 96) frame:CGRectMake(0, 0, ScreenWidth, 20)];
    [self.view addSubview:view];
    //上导航下的分割线
    UIView *lineview = [Factory createViewWithBackgroundColor:[UIColor grayColor] frame:CGRectMake(0, 63, ScreenWidth, 1)];
    [self.view addSubview:lineview];
    
    //
    //
    //创建自定义菜单的按钮
    
    [_slideView removeFromSuperview];
    [self createView];
    [self createMenuButton];
}

-(void)createView
{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars =NO;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.navigationController.navigationBar.translucent =NO;
    
//    colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor blackColor],[UIColor redColor],[UIColor yellowColor],[UIColor blackColor],[UIColor redColor],[UIColor yellowColor],[UIColor blackColor]];
    
//    _titleArray =@[@"有书头条",
//                                  @"头条",
//                                  @"要闻",
//                                  @"有书头条",
//                                  @"头条",
//                                  @"要闻",
//                                  @"有书头条",
//                                  @"头条",
//                                  @"要闻",
//                                  @"故事1",
//                                  @"故事2",
//                                  @"故事3",
//                                  @"故事4"];
//    _titleArray = [ArrayData defaultSelectedSubject];

    _slideView = [[YLSlideView alloc]initWithFrame:CGRectMake(0, 20,
                                                              ScreenWidth,
                                                              SCREEN_HEIGHT_YLSLIDE-49-20)
                                         forTitles:_titleArray];
    
    _slideView.backgroundColor = [UIColor whiteColor];
    _slideView.delegate        = self;
    [self.view addSubview:_slideView];

    
    

    //创建滚动视图
//    [self createScrollView];
}

-(void)createMenuButton
{
    UIButton *MenuButton = [Factory createButtonWithTitle:nil frame:CGRectMake(ScreenWidth-37, 7, 30, 30) target:self selector:@selector(toshowMenu)];
    MenuButton.backgroundColor = [UIColor blackColor];
    [MenuButton setImage:[UIImage imageNamed:@"iconfont-menu.png"] forState:UIControlStateNormal];
    [_slideView addSubview:MenuButton];
}

-(void)toshowMenu
{
    self.selectedSubjectArray = _titleArray;
    NSLog(@"~~~~~~~~%@",self.selectedSubjectArray);
    SubjectManageViewController *subjectVC = [SubjectManageViewController initWithSelectedSubjectAndParentController:self.selectedSubjectArray parentController:self];
    subjectVC.delegate = self;
    [self presentViewController:subjectVC animated:YES completion:nil];
}
#pragma mark -- 自定义菜单代理的实现
-(void)getSelectArray:(NSArray *)SelectArray
{
    self.selectedSubjectArray = SelectArray;
    NSLog(@"%@",SelectArray);
}

- (NSInteger)columnNumber{
    return _titleArray.count;
}

- (YLSlideCell *)slideView:(YLSlideView *)slideView
         cellForRowAtIndex:(NSUInteger)index{
    
    YLSlideCell * cell = [slideView dequeueReusableCell];
    
    if (!cell) {
        cell = [[YLSlideCell alloc]initWithFrame:CGRectMake(0, 0, 320, 500)
                                           style:UITableViewStylePlain];
        cell.delegate   = self;
        cell.dataSource = self;
    }
    
    //    cell.backgroundColor = colors[index];
    
    
    return cell;
}
- (void)slideVisibleView:(YLSlideCell *)cell forIndex:(NSUInteger)index{
    NSLog(@"index :%@  cell %@",@(index),cell);
    NSLog(@"刷新数据");
    NSLog(@"%lu",(unsigned long)index);
    [self GetNetData];
    [cell reloadData]; //刷新TableView
//    NSLog(@"刷新数据");
}
-(void)GetNetData
{
    NSLog(@"在这里获取参数，得到数据");
}





#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Identifier";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftDistance, LeftDistance, 80, 80)];
    [imageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    
    [cell.contentView addSubview:imageView];
    
    UIView *viewline = [Factory createViewWithBackgroundColor:[UIColor grayColor] frame:CGRectMake(LeftDistance+5, imageView.bottom+5, ScreenWidth-LeftDistance-5, 1)];
    [cell.contentView addSubview:viewline];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 60, 40)];
    label.text = [@(arc4random()%1000) stringValue];
    [cell.contentView addSubview:label];
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.hidesBottomBarWhenPushed = YES;
    CustomViewController *cvc = [[CustomViewController alloc] init];
    
    [self.navigationController pushViewController:cvc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
