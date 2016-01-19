//
//  SwimViewController.m
//  notice1
//
//  Created by mac on 16/1/13.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "SwimViewController.h"

@interface SwimViewController ()
{
    UIView *_view1;
    UIView *_view2;
    UIView *_sonView1;
}
@end

@implementation SwimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createView
{
    _view1 = [Factory createViewWithBackgroundColor:RedColor frame:CGRectMake(0, 64, ScreenWidth, Default)];
    [self.view addSubview:_view1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toShow)];
    tap.numberOfTapsRequired = 1;
    [_view1 addGestureRecognizer:tap];
    

//    if (_sonView1) {

//    }
//    else
//    {
        _view2 = [Factory createViewWithBackgroundColor:BlueColor frame:CGRectMake(0, _view1.bottom, ScreenWidth, Default)];
        [self.view addSubview:_view2];
//    }

}
-(void)toShow
{
    [_view2 removeFromSuperview];
    [_sonView1 removeFromSuperview];
    _sonView1 = [Factory createViewWithBackgroundColor:OrangeColor frame:CGRectMake(0, _view1.bottom, ScreenWidth, 100)];
    [self.view addSubview:_sonView1];
            _view2 = [Factory createViewWithBackgroundColor:BlueColor frame:CGRectMake(0, _sonView1.bottom, ScreenWidth, Default)];
            [self.view addSubview:_view2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toBack)];
    tap2.numberOfTapsRequired = 1;
    [_view2 addGestureRecognizer:tap2];
}
-(void)toBack
{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    [_view2 removeFromSuperview];
    [_sonView1 removeFromSuperview];
    _view2 = [Factory createViewWithBackgroundColor:BlueColor frame:CGRectMake(0, _view1.bottom, ScreenWidth, Default)];
    [self.view addSubview:_view2];
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
