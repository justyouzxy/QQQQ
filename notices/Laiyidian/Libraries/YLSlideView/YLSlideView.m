

#import "YLSlideView.h"
#import "YLSlideTitleView.h"
#import "YGPCache.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"


@interface YLSlideView()<UIScrollViewDelegate>
{
    CGPoint      _beginScrollOffset;
    NSInteger    _totaiPageNumber;   //内容总数
    NSMutableSet *_visibleCells;     //可见
    NSMutableSet *_recycledCells;    //循环
    NSArray      *_titles;
    NSUInteger   _prePageIndex;
        UIView *_SelectView;
    UIView *_SearchView;
}

//
- (void)slideViewRecycle;
- (BOOL)isVisibleCellForIndex:(NSUInteger)index;
- (void)configCellWithCell:(YLSlideCell*)cell forIndex:(NSUInteger)index;
//
- (void)configSlideView;

@end

@implementation YLSlideView

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titles  = [titles copy];
        _prePageIndex = 1000;
        [self configSlideView];
        
        //监听Delegate值改变以刷新数据，不想使用者做太多无谓的方法调用
        [self addObserver:self
               forKeyPath:@"delegate"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        
    }

    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"delegate"]) {
        [self reloadData];
    }
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"delegate"];
   
}
#pragma mark RecycledCell

- (void)slideViewRecycle{

#warning 此处是重新的写法，默认是加载两个view。如果想加载一个view 可在次修改
    CGRect mainScrollViewBounds = _mainScrollview.bounds;
    
    NSUInteger currentPage = CGRectGetMinX(mainScrollViewBounds)/SCREEN_WIDTH_YLSLIDE;
    
    NSUInteger nextPage    = CGRectGetMaxX(mainScrollViewBounds)/SCREEN_WIDTH_YLSLIDE;
    
    currentPage            = MAX(currentPage, 0);
    nextPage               = MIN(nextPage, _totaiPageNumber-1);
    
    //回收 unvisible cell
    for (YLSlideCell * cell  in _visibleCells) {
        
        if (cell.index < currentPage || cell.index > nextPage) {

            //保存偏移量
            [[YGPCache sharedCache]setDataToMemoryWithData:[NSStringFromCGPoint(cell.contentOffset) dataUsingEncoding:NSUTF8StringEncoding] forKey:[@(cell.index) stringValue]];
            
            
            [_recycledCells addObject:cell];
            [cell removeFromSuperview];
            
        }
    }
   
    [_visibleCells minusSet:_recycledCells];
    
    // 添加重用Cell
    for (NSUInteger index = currentPage ; index <= nextPage; index++) {
        
        if (![self isVisibleCellForIndex:index]) {
        
           YLSlideCell *cell = [_delegate slideView:self cellForRowAtIndex:index];
            [self configCellWithCell:cell forIndex:index];
            
            [_visibleCells addObject:cell];
            
        }
    }
}

- (YLSlideCell*)dequeueReusableCell{

    YLSlideCell * cell = [_recycledCells anyObject];
    
    if (cell) {
        [_recycledCells removeObject:cell];
    }
    
    return cell;
}

- (BOOL)isVisibleCellForIndex:(NSUInteger)index{

    BOOL isVisibleCell = NO;
    
    for (YLSlideCell * cell in _visibleCells) {
        
        if (cell.index == index) {
            isVisibleCell = YES;
            break;
        }
        
    }
    return isVisibleCell;
}

- (YLSlideCell*)visibleCellForIndex:(NSUInteger)index{

    YLSlideCell * visibleCell = nil;
    
    for (YLSlideCell * cell in _visibleCells) {
        
        if (cell.index == index) {
            visibleCell = cell;
            break;
        }
    }
    return visibleCell;
}
-(void)createScrollView
{
    
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    
    NSMutableArray *arr3 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 4; i++) {
        [arr2 addObject:[NSString stringWithFormat:@"%d.jpg",i]];
        //        [arr3 addObject:[NSString stringWithFormat:@"我是第%d张图片啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊",i]];
    };
    
    
    DCPicScrollView  *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0,35,ScreenWidth, 65) WithImageUrls:arr2];
    
    picView1.titleData = arr3;
    
    picView1.backgroundColor = [UIColor clearColor];
    [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("你点到我了😳index:%zd\n",index);
    }];
    
    picView1.AutoScrollDelay = 2.0f;
    
    [_mainScrollview addSubview:picView1];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
//    view.backgroundColor = BlueColor;
//    [_SelectView addSubview:view];
    
    
}

- (void)configCellWithCell:(YLSlideCell*)cell forIndex:(NSUInteger)index{
    
//    cell.index            = index;
//    CGRect cellFrame      = self.bounds;
//    cellFrame.origin.x    = CGRectGetWidth(self.frame)*index;
//    cellFrame.size.height = cellFrame.size.height - YLSildeTitleViewHeight;
//    
//    [cell setFrame:cellFrame];
    cell.index            = index;
    if (index == 0) {

//        [_SelectView removeFromSuperview];
        if (!_SearchView) {
            _SearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
            _SearchView.backgroundColor = BlueColor;
            [_mainScrollview addSubview:_SearchView];
        }

        cell.frame = CGRectMake(0, 100, ScreenWidth, ScreenHeight-49-100);
        [self createScrollView];
        
    }
    else
    {
        CGRect cellFrame      = CGRectMake(0, 35, ScreenWidth, ScreenHeight-44);
        cellFrame.origin.x    = CGRectGetWidth(self.frame)*index;
        cellFrame.size.height = cellFrame.size.height - YLSildeTitleViewHeight;
//        [_SelectView removeFromSuperview];
        [cell setFrame:cellFrame];
//        NSLog(@"%d",!_SelectView);
        if (!_SelectView) {
//
            _SelectView = [Factory createViewWithBackgroundColor:RedColor frame:CGRectMake(0, 35, ScreenWidth, 45)];
            NSLog(@"我就看看会创建多少个selectview");
            [self addSubview:_SelectView];

            for (int i = 0; i<4; i++) {
                UIButton *button = [Factory createButtonWithTitle:[NSString stringWithFormat:@"%d",i] frame:CGRectMake(0+i*ScreenWidth/4, 0, ScreenWidth/4, 45) backgroundColor:[UIColor grayColor] target:self selector:nil];
                                    [_SelectView addSubview:button];
            }
        
            
            
        }
    
    }
    
    [_mainScrollview addSubview:cell];
    
    if ([_delegate respondsToSelector:@selector(slideViewInitiatedComplete:forIndex:)]) {
        [_delegate slideViewInitiatedComplete:cell forIndex:index];
    }
    
    //获取偏移量
   __block YLSlideCell *newCell = cell;
    [[YGPCache sharedCache] dataForKey:[@(cell.index) stringValue] block:^(NSData *data, NSString *key) {
        
        if (data) {
            CGPoint offset = CGPointFromString([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            [newCell setContentOffset:offset];
        }
    }];
    
}

#pragma make reloadData

- (void)reloadData{

    [_visibleCells  removeAllObjects];
    [_recycledCells removeAllObjects];
    
    [[YGPCache sharedCache]removeMemoryAllData];
    
    __WEAK_SELF_YLSLIDE
    
    if ([_delegate respondsToSelector:@selector(columnNumber)]) {
        
            if (weakSelf) {
                
                __STRONG_SELF_YLSLIDE
                
                _totaiPageNumber = [strongSelf->_delegate columnNumber];

                [strongSelf.mainScrollview setContentSize:CGSizeMake(CGRectGetWidth(strongSelf.frame)*_totaiPageNumber, CGRectGetHeight(strongSelf.frame)-YLSildeTitleViewHeight)];
                
            }
    }

    [self slideViewRecycle];
    
    [self visibleViewDelegateForIndex:0];


}

- (void)visibleViewDelegateForIndex:(NSUInteger)index{

    if (_prePageIndex != index) {
        if ([_delegate respondsToSelector:@selector(slideVisibleView:forIndex:)]) {
            [_delegate slideVisibleView:[self visibleCellForIndex:index] forIndex:index];
        }
    }
    
    _prePageIndex = index;

}

#pragma mark UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _slideTitleView.isClickTitleButton = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self slideViewRecycle];

    if (!_slideTitleView.isClickTitleButton) {
        if (_slideTitleView.slideTitleViewScrollBlock) {
            _slideTitleView.slideTitleViewScrollBlock(scrollView.contentOffset.x);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self visibleViewDelegateForIndex:currentPage];

    if (_slideTitleView.slideViewWillScrollEndBlock) {
        _slideTitleView.slideViewWillScrollEndBlock(scrollView.contentOffset.x);
    }
    
}

#pragma mark configSlideView

- (void)configSlideView{
    
    _visibleCells  = [[NSMutableSet alloc]init];
    _recycledCells = [[NSMutableSet alloc]init];
    
    self.mainScrollview = ({
        
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, YLSildeTitleViewHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-YLSildeTitleViewHeight)];
        scrollView.bounces         = NO;
        scrollView.delegate        = self;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled   = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        scrollView;
    });
    [self addSubview:_mainScrollview];
    
    self.slideTitleView = ({
        
        CGRect slideTitleFrame;
        slideTitleFrame.origin = CGPointMake(0, 0);
        slideTitleFrame.size   = CGSizeMake(CGRectGetWidth(self.frame)-44, 44);
        
        YLSlideTitleView * slideTitleView = [[YLSlideTitleView alloc]initWithFrame:slideTitleFrame forTitles:_titles];
        
        slideTitleView;
    });
    [self addSubview:_slideTitleView];
    
    __WEAK_SELF_YLSLIDE
    // slideTitleView 栏目button 点击的监听
    // 滚动到指定的栏目下
    _slideTitleView.slideTitleViewClickButtonBlock = ^(NSUInteger index){
        
        if (weakSelf) {
            
            __STRONG_SELF_YLSLIDE
            CGRect frame   = strongSelf.mainScrollview.bounds;
            frame.origin.x = CGRectGetWidth(strongSelf.frame) * index;
            
            [strongSelf.mainScrollview scrollRectToVisible:frame animated:NO];
            [strongSelf visibleViewDelegateForIndex:index];
        }
    };
}


#pragma mark Set Get
- (void)setShowsScrollViewHorizontalScrollIndicator:(BOOL)showsScrollViewHorizontalScrollIndicator{
    
    _mainScrollview.showsHorizontalScrollIndicator = showsScrollViewHorizontalScrollIndicator;

}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com