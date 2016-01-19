//
//  LoginPersonnolViewController.m
//  notice1
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "LoginPersonnolViewController.h"
#import "AddressChoicePickerView.h"
@interface LoginPersonnolViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *_NicknameTextfiled;
    UITextField *_ConpanyTextfiled;
    UITextView *_PersonnalTextview;
    UILabel *_AgeTextfiled;
    UIPickerView *_AgePickerView;
    NSMutableArray *_PickArray;
    NSMutableArray *_PickArray2;
    NSMutableArray *_PickArray3;
    NSString *_string1;
    NSString *_string2;
    
    UILabel *_AddressTextfiled;
    UIPickerView *_AddressPickerView;
    
    UIButton *_ManButton;
    
    UIView *_view1;
}
@end

@implementation LoginPersonnolViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    _PickArray = [[NSMutableArray alloc] init];
    _PickArray2 = [[NSMutableArray alloc] init];
    _PickArray3 = [[NSMutableArray alloc] init];
    for (int i = 1960; i<2025 ; i++) {
        [_PickArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 1; i<13; i++) {
        [_PickArray2 addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    for (int i = 1; i<32; i++) {
        [_PickArray3 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
//    NSLog(@"%@",_PickArray);
}

-(void)createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(LeftDistance, 64, ScreenWidth-2*LeftDistance, ScreenHeight/2+80) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIButton *ResultButton = [Factory createButtonWithTitle:@"提交" frame:CGRectMake(50, _tableView.bottom+2*LeftDistance, ScreenWidth-100, Default) backgroundColor:RGB(48, 155, 204) target:self selector:@selector(SaveMsToServe)];
    ResultButton.titleLabel.textColor = WhiteColor;
    [self.view addSubview:ResultButton];
    
}
-(void)SaveMsToServe
{
    NSLog(@"nickname=%@",_NicknameTextfiled.text);
    if([_ManButton isSelected])
    {
        NSLog(@"性别=男");
    }
    else
    {
        NSLog(@"性别=女");
    }
    NSLog(@"出生年月日=%@",_AgeTextfiled.text);
    NSLog(@"所在地=%@",_AddressTextfiled.text);
    NSLog(@"公司单位=%@",_ConpanyTextfiled.text);
    NSLog(@"个人介绍=%@",_PersonnalTextview.text);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
                UILabel *label = [Factory createLabelWithTitle:@"我的头像:" frame:CGRectMake(LeftDistance, LeftDistance+5, 80, 30) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 5, 50, 50)];
            imageview.layer.cornerRadius = 25;
            imageview.layer.masksToBounds = YES;
            imageview.backgroundColor = OrangeColor;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toPickHeadImage)];
            tap.numberOfTapsRequired = 1;
            [imageview addGestureRecognizer:tap];
            [cell.contentView addSubview:imageview];
        };break;
        case 1:{
            UILabel *label = [Factory createLabelWithTitle:@"我的昵称:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
            _NicknameTextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/3, 5, ScreenWidth/3*2-2*LeftDistance, 35) placeholder:@"请输入你的昵称" textColor:BlackColor borderStyle:UITextBorderStyleRoundedRect];
            [_NicknameTextfiled setValue:[UIFont boldSystemFontOfSize:10] forKeyPath:@"_placeholderLabel.font"];
            [cell.contentView addSubview:_NicknameTextfiled];
            
        };break;
        case 2:{
            UILabel *label = [Factory createLabelWithTitle:@"性别:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
            _ManButton = [Factory createButtonWithTitle:@"" frame:CGRectMake(ScreenWidth/3, LeftDistance, ScreenWidth/5, 25) backgroundColor:nil target:self selector:@selector(toSelectMan:)];
            [_ManButton setImage:[UIImage imageNamed:@"welcome_2.png"] forState:UIControlStateNormal];
            _ManButton.tag = 101;
            [cell.contentView addSubview:_ManButton];
            
//            UIButton *ManButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            ManButton.frame = CGRectMake(ScreenWidth/3, LeftDistance, ScreenWidth/5, 25);
//            ManButton.titleLabel.text = @"男";
//            ManButton.titleLabel.textColor = [UIColor grayColor];
//            ManButton.backgroundColor = [UIColor grayColor];
//            ManButton.backgroundColor = WhiteColor;
//            [cell.contentView addSubview:ManButton];
            
            UIButton *WomanButton = [Factory createButtonWithTitle:@"" frame:CGRectMake(ScreenWidth/3+2*LeftDistance+ScreenWidth/5, LeftDistance, ScreenWidth/5, 25) backgroundColor:nil target:self selector:@selector(toSelectWoman:)];
            WomanButton.tag = 102;
            [WomanButton setImage:[UIImage imageNamed:@"welcome_2.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:WomanButton];
            
//            UIButton *WomanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            WomanButton.frame = CGRectMake(ScreenWidth/3+2*LeftDistance+ScreenWidth/5, LeftDistance, ScreenWidth/5, 25);
//            WomanButton.backgroundColor = [UIColor grayColor];
//            WomanButton.titleLabel.text = @"女";
//            WomanButton.titleLabel.textColor = [UIColor blackColor];
//            WomanButton.backgroundColor = WhiteColor;
//            [cell.contentView addSubview:WomanButton];
            
        };break;
        case 3:{
            UILabel *label = [Factory createLabelWithTitle:@"年龄:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];

//             [_AgeTextfiled removeFromSuperview];
//            _AgeTextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3*2-2*LeftDistance, 25) placeholder:nil textColor:[UIColor grayColor] borderStyle:UITextBorderStyleRoundedRect];
            _AgeTextfiled = [Factory createLabelWithTitle:@"点击选择出生年月日" frame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3*2-2*LeftDistance, 25) textColor:[UIColor grayColor] fontSize:12.f];
            _AgeTextfiled.userInteractionEnabled = YES;
//            _AgeTextfiled.delegate = self;
//            [_AgeTextfiled removeFromSuperview];
//            _AgeTextfiled.inputView = _AgePickerView;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toSelectBirthday)];
            tap.numberOfTapsRequired = 1;
            [_AgeTextfiled addGestureRecognizer:tap];
            _AgeTextfiled.tag =1001;
            [cell.contentView addSubview:_AgeTextfiled];

            
            
        };break;
        case 4:{
            UILabel *label = [Factory createLabelWithTitle:@"所在地区:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
//            _AddressTextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3*2-2*LeftDistance, 25) placeholder:nil textColor:[UIColor grayColor] borderStyle:UITextBorderStyleRoundedRect];
            _AddressTextfiled = [Factory createLabelWithTitle:@"点击选择地址" frame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3*2-2*LeftDistance, 25) textColor:[UIColor grayColor] fontSize:12.f];
            _AddressTextfiled.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAddAddress)];
            tap.numberOfTapsRequired = 1;
            [_AddressTextfiled addGestureRecognizer:tap];
            _AgeTextfiled.tag = 1002;
            [cell.contentView addSubview:_AddressTextfiled];
            
            
        };break;
        case 5:{
            UILabel *label = [Factory createLabelWithTitle:@"公司单位:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
            _ConpanyTextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/3, 5, ScreenWidth/3*2-2*LeftDistance, 35) placeholder:@"请输入你的公司单位" textColor:BlackColor borderStyle:UITextBorderStyleRoundedRect];
            [_ConpanyTextfiled setValue:[UIFont boldSystemFontOfSize:10] forKeyPath:@"_placeholderLabel.font"];
            [cell.contentView addSubview:_ConpanyTextfiled];
        };break;
            
        default:{
            UILabel *label = [Factory createLabelWithTitle:@"个人介绍:" frame:CGRectMake(LeftDistance, 5, 80, 35) textColor:BlackColor fontSize:17.f];
            [cell.contentView addSubview:label];
            
            _PersonnalTextview = [[UITextView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 5,ScreenWidth/3*2-2*LeftDistance,70)];
            _PersonnalTextview.backgroundColor = RGBA(195, 195, 195, 0.5);
            _PersonnalTextview.layer.cornerRadius = 5;
            _PersonnalTextview.layer.masksToBounds = YES;
            _PersonnalTextview.layer.borderColor =[[UIColor colorWithRed:195.0 / 255.0 green:195.0 / 255.0 blue:195.0 / 255.0 alpha:0.5] CGColor];
            _PersonnalTextview.layer.borderWidth = 0.6;
            [cell.contentView addSubview:_PersonnalTextview];
            
        };break;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selected = NO;
//    cell.selectedBackgroundView = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)toSelectBirthday
{
    _view1 = [Factory createViewWithBackgroundColor:WhiteColor frame:CGRectMake(0, ScreenHeight/3*2-40,ScreenWidth  , 240)];
    [self.view addSubview:_view1];
    
    _AgePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40,ScreenWidth  , 200)];
    _AgePickerView.delegate = self;
    _AgePickerView.dataSource = self;
    _AgePickerView.backgroundColor = WhiteColor;
    _AgePickerView.tag = 10001;
    _AgePickerView.userInteractionEnabled = YES;
    [_view1 addSubview:_AgePickerView];
    UIButton *button = [Factory createButtonWithTitle:@"确定" frame:CGRectMake(ScreenWidth-60, 0,50, Default) backgroundColor:WhiteColor target:self selector:@selector(toCancel)];
//    button.titleLabel.textColor = BlueColor;
    [button setTitleColor:BlueColor forState:UIControlStateNormal];
    [_view1 addSubview:button];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCancel)];
//    tap.numberOfTapsRequired = 1;
//    [button addGestureRecognizer:tap];
}
-(void)toAddAddress
{
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        _AddressTextfiled.text = [NSString stringWithFormat:@"%@",locate];
        _AddressTextfiled.textColor = [UIColor blackColor];
    };
    [addressPickerView show];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:return 60;break;
        case 6:return 80;break;

        default:return 45;
            break;
    }
}
-(void)toSelectWoman:(UIButton *)button
{
    UIButton *button1 = (UIButton *)[self.view viewWithTag:101];
    [button1 setImage:[UIImage imageNamed:@"welcome_2.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"welcome_3.png"] forState:UIControlStateNormal];

}
-(void)toSelectMan:(UIButton *)button
{
    
    UIButton *button1 = (UIButton *)[self.view viewWithTag:102];
    [button1 setImage:[UIImage imageNamed:@"welcome_2.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"welcome_3.png"] forState:UIControlStateNormal];
}

-(void)toPickHeadImage
{
    
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
////    [_AgeTextfiled removeFromSuperview];
//    
//
//
//    
//}
-(void)toCancel
{
    NSLog(@"~~~~~~~~~~");
    [_view1 removeFromSuperview];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_AgePickerView removeFromSuperview];
    [_AddressPickerView removeFromSuperview];
}


//显示列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

        if (component == 0) {
            return _PickArray.count;
        }
        else if(component == 1)
        {
            return _PickArray2.count;
        }
        else
        {
            return _PickArray3.count;
        }


    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 80;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
        if (component == 0) {
            _AgeTextfiled.text = [NSString stringWithFormat:@"%@",[_PickArray objectAtIndex:row]];
            _string1 = [[NSString alloc] init];
            _string1 = _AgeTextfiled.text;
        }
        else if(component == 1)
        {
            _AgeTextfiled.text = nil;
            _AgeTextfiled.text = [_string1 stringByAppendingString:[NSString stringWithFormat:@"-%@",[_PickArray2 objectAtIndex:row]]];
            _string2 = [[NSString alloc] init];
            _string2 = _AgeTextfiled.text;
        }
        else
        {
            _AgeTextfiled.text = nil;
            _AgeTextfiled.text = [_string2 stringByAppendingString:[NSString stringWithFormat:@"-%@",[_PickArray3 objectAtIndex:row]]];;
        }


    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

        if (component == 0) {
            return [_PickArray objectAtIndex:row];
        }
        else if(component == 1)
        {
            return [_PickArray2 objectAtIndex:row];
        }
        else
        {
            return [_PickArray3 objectAtIndex:row];
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
