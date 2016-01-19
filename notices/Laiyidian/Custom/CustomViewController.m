//
//  CustomViewController.m
//  notice1
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "CustomViewController.h"


@interface CustomViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_backgrandImage;
}
@end

@implementation CustomViewController

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    // Do any additional setup after loading the view.
}
-(void)createView
{
    [self createImageView];
    [self createTableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"selectbutton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toSelect)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    
}
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)createSelectButton
{
//    UIButton *button = [Factory createButtonWithTitle:@"" frame:CGRectMake(ScreenWidth-Default, 20, Default, Default) backgroundColor:OrangeColor target:self selector:@selector(toSelect)];
//    [self.view addSubview:button];
}
-(void)toSelect
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拉黑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拉黑");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"举报");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)createImageView
{
    //头像后的背景图片
    _backgrandImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4)];
    _backgrandImage.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:_backgrandImage];
    //头像
    UIImageView *HeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-Default, LeftDistance, (ScreenHeight/4)/2, (ScreenHeight/4)/2)];
    HeadImage.backgroundColor = WhiteColor;
    HeadImage.layer.cornerRadius = 5;
    HeadImage.layer.masksToBounds = YES;
    [_backgrandImage addSubview:HeadImage];
    
    UILabel *placeLabel = [Factory createLabelWithTitle:nil frame:CGRectMake(0, _backgrandImage.bottom-30, ScreenWidth, 30) textColor:WhiteColor fontSize:12.f];
    placeLabel.backgroundColor = RGBA(1, 1, 1, 0.5);
    placeLabel.text = @"湖北省武汉市江夏区&0.5km";
    placeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:placeLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 0.1;
    if (section == 0) {
        return ScreenHeight/4;
    }else
    {
        return 0.1;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [Factory createViewWithBackgroundColor:WhiteColor frame:CGRectMake(0, 64, ScreenWidth, ScreenHeight/4)];
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:view.bounds];
        backgroundImage.image = [UIImage imageNamed:@"background.jpg"];
        [view addSubview:backgroundImage];
        //头像
        UIImageView *HeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-Default, LeftDistance, (ScreenHeight/4)/2, (ScreenHeight/4)/2)];
        HeadImage.backgroundColor = WhiteColor;
        HeadImage.layer.cornerRadius = 5;
        HeadImage.layer.masksToBounds = YES;
        [view addSubview:HeadImage];
        
        UILabel *placeLabel = [Factory createLabelWithTitle:nil frame:CGRectMake(0, view.frame.size.height-30, ScreenWidth, 30) textColor:WhiteColor fontSize:12.f];
        placeLabel.backgroundColor = RGBA(1, 1, 1, 0.5);
        placeLabel.text = @"湖北省武汉市江夏区&0.5km";
        placeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:placeLabel];

        return view;
    }
    else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Default;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return Default;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[_dataSource objectAtIndex:section] count];
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [_dataSource count];
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
//    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            [self createAlertView];
//        }else if (indexPath.row == 1)
//        {
//            [self tellUs];
//        }
//        
//    }else
//    {
//        [self IntruductUs];
//    }
//    
//    
//    
//}

@end
