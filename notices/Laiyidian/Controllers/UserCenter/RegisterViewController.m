//
//  RegisterViewController.m
//  notice1
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UITextField *_Teltextfiled;
    UITextField *_Testtextfiled;
    UITextField *_Passwordtextfiled;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)createView
{
    UILabel *label = [Factory createLabelWithTitle:@"请保持手机畅通，用于接收验证码" frame:CGRectMake(50, 70, ScreenWidth-100, 20) textColor:nil fontSize:10.f];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIImageView *TelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, label.bottom+5, ScreenWidth-100, Default)];
    TelImageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:TelImageView];
    
    _Teltextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/10, 0, TelImageView.frame.size.width-ScreenWidth/10, Default) placeholder:@"请输入手机号" textColor:BlackColor borderStyle:UITextBorderStyleNone];
    [_Teltextfiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [TelImageView addSubview:_Teltextfiled];
    
    UIImageView *testimageview = [[UIImageView alloc] initWithFrame:CGRectMake(50, TelImageView.bottom, ScreenWidth-200, Default)];
    testimageview.image = [UIImage imageNamed:@""];
    [self.view addSubview:testimageview];
    
    UIButton *testButton = [Factory createButtonWithTitle:@"获取验证码" frame:CGRectMake(ScreenWidth-50-ScreenWidth/10, TelImageView.bottom, ScreenWidth/10+20, Default) backgroundColor:[UIColor grayColor] target:self selector:@selector(toGetTestcode)];
    [self.view addSubview:testButton];
    
    
    
    UIImageView *PasswordImageview = [[UIImageView alloc] initWithFrame:CGRectMake(50, TelImageView.bottom, ScreenWidth-100, Default)];
    PasswordImageview.image = [UIImage imageNamed:@""];
    [self.view addSubview:PasswordImageview];
    
    _Passwordtextfiled = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/10, 0, TelImageView.frame.size.width-ScreenWidth/10, Default) placeholder:@"请输入密码" textColor:BlackColor borderStyle:UITextBorderStyleNone];
    [_Passwordtextfiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [PasswordImageview addSubview:_Passwordtextfiled];
    
    UIButton *RegisterButton = [Factory createButtonWithTitle:@"提交" frame:CGRectMake(50, PasswordImageview.bottom+20, ScreenWidth-100, Default) backgroundColor:[UIColor grayColor] target:self selector:@selector(toConfigRegister)];
    [self.view addSubview:RegisterButton];
    
}
-(void)toConfigRegister
{
    
}
-(void)toGetTestcode
{
    
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
