//
//  NewsScrollView.m
//  TestExam
//
//  Created by Hailong.wang on 15/10/20.
//  Copyright © 2015年 Hailong.wang. All rights reserved.
//

#import "NewsScrollView.h"

//顶部滚动视图的高度
#define TopScrollViewHeight 43
//内容滚动视图的高度
#define ContentScorllViewHeight self.height - TopScrollViewHeight
//顶部滚动视图按钮的宽度
#define TopScrollButtonWidth self.width / 4

@interface NewsScrollView () <UIScrollViewDelegate>

//顶部滚动视图子视图的title
PropertyStrong(NSArray, titles);
//内容滚动视图子视图的控制器数组
PropertyStrong(NSArray, viewControllers);
//顶部的滚动视图
PropertyStrong(UIScrollView, topView);
//内容滚动视图
PropertyStrong(UIScrollView, contentView);
@property (nonatomic,assign)NSInteger lastTag;
@property (nonatomic,assign)NSInteger lastPage;
@end

@implementation NewsScrollView

//初始化重定义
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titls {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titls;
        //拿到了titles，就确定了有多少页，多少按钮，偏移多少，就可以创建视图了。
        [self createView];
    }
    self.lastTag = 100;
    return self;
}

- (void)createView {
    //创建顶部滚动视图
    [self createTopView];
}

- (void)createTopView {
    self.topView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, TopScrollViewHeight)];
    self.topView.backgroundColor = [UIColor whiteColor];
//    self.topView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, Default)];
    self.topView.contentSize = CGSizeMake(TopScrollButtonWidth*self.titles.count, 0);
    self.topView.showsHorizontalScrollIndicator = YES;
    [self addSubview:self.topView];
    
//    UIView *lineview = [Factory createViewWithBackgroundColor:BlackColor frame:CGRectMake(0, 63, ScreenWidth, 1)];
//    [self.topView addSubview:lineview];
    
    
    [self addSubButton];

}

- (void)addSubButton {
    
    UIButton *button = [Factory createButtonWithTitle:[self.titles objectAtIndex:0] frame:CGRectMake(0, 0, TopScrollButtonWidth, TopScrollViewHeight) backgroundColor:[UIColor clearColor] target:self selector:@selector(buttonDidClicked:)];
    button.tag = 100;
    [button setTitleColor:OrangeColor forState:UIControlStateNormal];
    [self.topView addSubview:button];
    
    for (int i = 1; i < [self.titles count]; i ++) {
        UIButton *button = [Factory createButtonWithTitle:[self.titles objectAtIndex:i] frame:CGRectMake(i * TopScrollButtonWidth, 0, TopScrollButtonWidth, TopScrollViewHeight) backgroundColor:[UIColor clearColor] target:self selector:@selector(buttonDidClicked:)];
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
//        [button setTitleColor:OrangeColor forState:UIControlStateSelected];
        button.tag = 100 + i;
        [self.topView addSubview:button];
    }
}

//button的点击事件，根据传进来的button的tag值，来判断内容滚动视图要偏移多少来对应。
- (void)buttonDidClicked:(UIButton *)button {
    
    //判断上面按钮点击前上个按钮的点击状态
//    NSLog(@"%ld",(long)self.lastPage);
    if (self.lastPage) {
        UIButton *button = (UIButton *)[self.topView viewWithTag:self.lastPage+100];
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
    }
    
    
    if (self.lastTag) {
        UIButton *button = (UIButton *)[self.topView viewWithTag:self.lastTag];
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
    }
    
    NSInteger page = button.tag - 100;
    
    [button setTitleColor:OrangeColor forState:UIControlStateNormal];
    self.contentView.contentOffset = CGPointMake(page * self.contentView.width, 0);
    self.lastTag = button.tag;
    self.lastPage = button.tag-100;
}

//设置内容视图
- (void)setSubviewController:(NSArray *)controller {
    self.viewControllers = controller;
    //拿到子视图就可以创建内容滚动视图
    [self createBottomView];
    //将子视图添加到内容视图上
    [self addSubViewToContentView];
}

- (void)addSubViewToContentView {
    for (int i = 0; i < self.viewControllers.count; i ++) {
        UIViewController *controller = [self.viewControllers objectAtIndex:i];
        controller.view.frame = CGRectMake(i * self.width, 0, self.width, ContentScorllViewHeight);
        [self.contentView addSubview:controller.view];
    }
    //设置内容视图的内容尺寸
    self.contentView.contentSize = CGSizeMake(self.width * self.viewControllers.count, 0);
}

- (void)createBottomView {
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, self.width, ContentScorllViewHeight)];
    self.contentView.delegate = self;
    self.contentView.pagingEnabled = YES;
    [self addSubview:self.contentView];
}

#pragma mark - UIScrollViewDelegate
//当scrollView减速时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    //将floorf()括号内的计算结果变成float类型
    NSInteger page = floorf(scrollView.contentOffset.x - scrollView.width)/scrollView.width + 1;
    if (self.lastPage == 3&&page == 4) {
        self.topView.contentOffset = CGPointMake(TopScrollButtonWidth*2, 0);
    }
    if (self.lastPage == 2&&page == 1) {
        self.topView.contentOffset = CGPointMake(0, 0);
    }
    
    
//     NSLog(@"~~~~~~~~~~%ld",(long)page);
    //根据页码+100 = button.tag可以去到button，根据偏移指定对应tag值的button修改标题颜色
    UIButton *button = (UIButton *)[self.topView viewWithTag:page + 100];
    [button setTitleColor:OrangeColor forState:UIControlStateNormal];
    self.lastPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //将floorf()括号内的计算结果变成float类型
    NSInteger page = floorf(scrollView.contentOffset.x - scrollView.width)/scrollView.width + 1;
   
    //根据页码+100 = button.tag可以去到button，根据偏移指定对应tag值的button修改标题颜色
    UIButton *button = (UIButton *)[self.topView viewWithTag:page + 100];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    NSLog(@"~~~~~~~~%ld",self.lastPage);
}

@end





