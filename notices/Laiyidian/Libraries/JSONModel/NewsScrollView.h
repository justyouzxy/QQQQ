//
//  NewsScrollView.h
//  TestExam
//
//  Created by Hailong.wang on 15/10/20.
//  Copyright © 2015年 Hailong.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsScrollView : UIView

//初始化重定义
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titls;
//设置内容视图
- (void)setSubviewController:(NSArray *)controller;

@end



