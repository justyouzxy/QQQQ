//
//  LoginViewController.m
//  laiyidian
//
//  Created by mac on 16/1/16.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginPersonnolViewController.h"
@interface LoginViewController ()
{
    UIImageView *_imageView;
    UITextField *_UserNameText;
    UITextField *_Password;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageView.image = [UIImage imageNamed:@"background.png"];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    
    UIImageView *userimageview = [[UIImageView alloc] initWithFrame:CGRectMake(Default, ScreenHeight/2-2*Default, ScreenWidth-Default*2, Default-10)];
    userimageview.image = [UIImage imageNamed:@"user.png"];
    [_imageView addSubview:userimageview];
    
    UIImageView *passwordimageview = [[UIImageView alloc] initWithFrame:CGRectMake(Default, userimageview.bottom+LeftDistance, ScreenWidth-Default*2, Default-10)];
    passwordimageview.image = [UIImage imageNamed:@"password.png"];
    [_imageView addSubview:passwordimageview];
    
    
    
    
    _UserNameText = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/10, 0, userimageview.frame.size.width-30, userimageview.frame.size.height) placeholder:@"登录" textColor:WhiteColor borderStyle:UITextBorderStyleNone];
    [_UserNameText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    userimageview.userInteractionEnabled = YES;
    [userimageview addSubview:_UserNameText];
    
    _Password = [Factory createViewWithText:nil frame:CGRectMake(ScreenWidth/10, 0, passwordimageview.frame.size.width-30, passwordimageview.frame.size.height) placeholder:@"密码" textColor:WhiteColor borderStyle:UITextBorderStyleNone];
    [_Password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordimageview.userInteractionEnabled = YES;
    [passwordimageview addSubview:_Password];
    
    
    
    UIButton *loginButton = [Factory createButtonWithTitle:nil frame:CGRectMake(Default, passwordimageview.bottom+LeftDistance, ScreenWidth-2*Default, Default-10) backgroundColor:nil target:self selector:@selector(toLogin:)];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"S1.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"S2.png"] forState:UIControlStateHighlighted];
    [_imageView addSubview:loginButton];
    
    UIButton *registerButton = [Factory createButtonWithTitle:nil frame:CGRectMake(Default, loginButton.bottom+LeftDistance, ScreenWidth-2*Default, Default-10) backgroundColor:nil target:self selector:@selector(toRegister:)];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"S1.png"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"S2.png"] forState:UIControlStateHighlighted];
    [_imageView addSubview:registerButton];
    
    UIButton *ForgetButton = [Factory createButtonWithTitle:@"忘记密码?" frame:CGRectMake(ScreenWidth-Default-50, registerButton.bottom+5, 50, 30) backgroundColor:nil target:self selector:@selector(toRegetPassword:)];
    ForgetButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_imageView addSubview:ForgetButton];
    
    
    UILabel *label = [Factory createLabelWithTitle:@"其他账号登录" frame:CGRectMake(ScreenWidth/2-40, ForgetButton.bottom+10, 80, 34) textColor:WhiteColor fontSize:12.f];
    label.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:label];
    
    UIView *view1 = [Factory createViewWithBackgroundColor:WhiteColor frame:CGRectMake(0, ForgetButton.bottom+10+(label.frame.size.height/2), ScreenWidth/2-60, 1)];
    [_imageView addSubview:view1];
    
    UIView *view2 = [Factory createViewWithBackgroundColor:WhiteColor frame:CGRectMake(ScreenWidth/2+60, ForgetButton.bottom+10+(label.frame.size.height/2), ScreenWidth/2-60, 1)];
    [_imageView addSubview:view2];
    
    UIButton *QqButton = [Factory createButtonWithTitle:nil frame:CGRectMake(ScreenWidth/2-Default/2, label.bottom+20, Default, Default) backgroundColor:nil target:self selector:@selector(toSinaLogin:)];
    [QqButton setImage:[UIImage imageNamed:@"S1.png"] forState:UIControlStateNormal];
    [_imageView addSubview:QqButton];
    
    
    UIButton *SinaButton = [Factory createButtonWithTitle:nil frame:CGRectMake(ScreenWidth/2-Default/2-30-Default, label.bottom+20, Default, Default) backgroundColor:nil target:self selector:@selector(toQQlogin:)];
    [SinaButton setImage:[UIImage imageNamed:@"S2.png"] forState:UIControlStateNormal];
    [_imageView addSubview:SinaButton];
    
    UIButton *WeixinButton = [Factory createButtonWithTitle:nil frame:CGRectMake(ScreenWidth/2+30+Default/2, label.bottom+20, Default, Default) backgroundColor:nil target:self selector:@selector(toWeixinlogin:)];
    [WeixinButton setImage:[UIImage imageNamed:@"S3.png"] forState:UIControlStateNormal];
    [_imageView addSubview:WeixinButton];
    
}
-(void)toWeixinlogin:(UIButton *)button
{
    
}
-(void)toQQlogin:(UIButton *)button
{
    
}
-(void)toSinaLogin:(UIButton *)button
{
    
}
-(void)toRegetPassword:(UIButton *)button
{
    NSLog(@"点击了忘记密码");
}
-(void)toLogin:(UIButton *)button
{
    LoginPersonnolViewController *lsvc = [[LoginPersonnolViewController alloc] init];
    [self.navigationController pushViewController:lsvc animated:YES];
    NSLog(@"点击了登录按钮");
    
}
-(void)toRegister:(UIButton *)button
{
    RegisterViewController *registerv = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerv animated:YES];
    NSLog(@"点击了注册按钮");
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
