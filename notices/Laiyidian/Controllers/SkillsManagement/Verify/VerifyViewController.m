//
//  ViewController.m
//  laiyidian
//
//  Created by 佳达 on 16/1/18.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import "VerifyViewController.h"
#import "UserVerityTableViewCell.h"

#import "HWPopTool.h"


@interface VerifyViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIView *contentView;


@property (nonatomic, strong) UserVerityTableViewCell *cell;

//原始数据
@property (nonatomic, strong) NSMutableArray *dataSoucre;
//选中行
@property (nonatomic, assign) NSIndexPath *currentIndexPath;

@end

@implementation VerifyViewController

- (NSMutableArray *)dataSoucre {
    if (!_dataSoucre) {
        _dataSoucre = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"zhanweitu.jpg"],[UIImage imageNamed:@"zhanweitu.jpg"],[UIImage imageNamed:@"zhanweitu.jpg"], nil];
    }
    return _dataSoucre;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:ScreeFrame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSegment];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserVerityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"userVerify"];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reloadTableView:)];
    swip.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:swip];
    
}
- (void)initSegment {
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"身份认证",@"技能认证"]];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.segment.backgroundColor = WhiteColor;
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    //    self.segment setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#> barMetrics:<#(UIBarMetrics)#>
    self.navigationItem.titleView = self.segment;
}

- (void)reloadTableView:(UISwipeGestureRecognizer *)swip {
    if (swip.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.segment.selectedSegmentIndex = 1;
        [self.tableView reloadData];
    }else if (swip.direction == UISwipeGestureRecognizerDirectionRight) {
        self.segment.selectedSegmentIndex = 0;
        [self.tableView reloadData];
    }
}
- (void)segmentValueChanged:(UISegmentedControl *)segment {
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
//            self.view.backgroundColor = OrangeColor;
            [self.tableView reloadData];
            break;
        case 1:
//            self.view.backgroundColor = RedColor;
            [self.tableView reloadData];
            break;
//        case 2:
////            self.view.backgroundColor = RedColor;
//            [self.tableView reloadData];
//            break;
        default:
            break;
    }
}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.segment.selectedSegmentIndex == 0 ? 3 : 1000;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segment.selectedSegmentIndex == 0) {
        self.cell = [tableView dequeueReusableCellWithIdentifier:@"userVerify" forIndexPath:indexPath];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.cell.titleLB.text = [NSString stringWithFormat:@"测试数据 %u",arc4random() % 100];
        [self.cell.clickButton setTitle:@"点我" forState:UIControlStateNormal];
        [self.cell.clickButton addTarget:self action:@selector(showExample) forControlEvents:UIControlEventTouchUpInside];
        [self.cell.userIDImageView setImage:self.dataSoucre[indexPath.row]];
        
        return self.cell;
    }else if(self.segment.selectedSegmentIndex == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Verify"];
        cell.textLabel.text = [NSString stringWithFormat:@"测试数据 %u",arc4random() % 100];
        return cell;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.segment.selectedSegmentIndex == 0 ? 80 : 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell.userIDImageView.tag = indexPath.row;
    NSLog(@"点中了 %lu 行",indexPath.row);
    self.currentIndexPath = indexPath;
    [self pushAlert];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.segment.selectedSegmentIndex == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [self tableView:tableView heightForFooterInSection:section])];
        NSInteger pading = 15;
        UILabel *lable = [Factory createLabelWithTitle:@"" frame:CGRectMake(Pading, pading, ScreenWidth - 2 * Pading, view.frame.size.height / 3 * 2 -pading) fontSize:20];
        lable.backgroundColor = OrangeColor;
        lable.numberOfLines = 0;
        lable.text = @"sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
        
        UIButton *button = [Factory createButtonWithTitle:@"保存" frame:CGRectMake(Pading, lable.frame.size.height + 2 * pading, lable.frame.size.width, lable.frame.size.height / 2) target:self selector:@selector(save:)];
        
        [view addSubview:lable];
        [view addSubview:button];
        return view;
    }
    return 0;
}
- (void)save:(NSIndexPath *)indexPath{
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.dataSoucre[indexPath.row]];
//    imageView.frame = CGRectMake(0, 0, 300, 300);
//    imageView.center = self.view.center;
//    
//    [self.view addSubview:imageView];
    NSLog(@"存储");
}
#pragma mark - 显示实例
- (void)showExample {
    NSLog(@"显示实例");
    [self popViewShow];
}
- (void)popViewShow {
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    _contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    imageView.frame = _contentView.frame;
    imageView.center = _contentView.center;
    
    
    [_contentView addSubview:imageView];
    
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];
    
}
/*
- (void)addPhotos:(UserVerityTableViewCell *)cell {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    cell.userIDImageView.userInteractionEnabled = YES;
//    [cell.userIDImageView addGestureRecognizer:tap];
//    cell.userIDImageView.tag += 1;
}


- (void)tap:(UITapGestureRecognizer *)tap {
    NSLog(@" tag %lu",self.cell.userIDImageView.tag);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        //退出系统相册
        [self pushAlbum];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        //调出照相机
        [self pushCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {  }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
*/

- (void)pushAlert {
    NSLog(@"选中的图片 tag %lu",self.cell.userIDImageView.tag);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册 + %lu",self.cell.userIDImageView.tag);
        //退出系统相册
        [self pushAlbum];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        //调出照相机
        [self pushCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)pushAlbum {
  
    UIImagePickerController* upc = [[UIImagePickerController alloc] init];
    upc.delegate = self;
    //开启编辑，放大缩小
    upc.allowsEditing = self;
    //推出相册
    [self presentViewController:upc animated:YES completion:nil];

}
- (void)pushCamera {
    UIImagePickerController *upc = [[UIImagePickerController alloc] init];
    upc.sourceType = UIImagePickerControllerSourceTypeCamera;
    upc.delegate = self;
    upc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //开启编辑，选中拍摄相片
    upc.allowsEditing = YES;
    [self presentViewController:upc animated:YES completion:nil];
    
}

#pragma mark --- 实现代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSInteger tag = self.cell.userIDImageView.tag;
    NSLog(@"存储时 图片 Tag  = %lu",tag);
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _dataSoucre[_currentIndexPath.row] = image;
    
    [self.tableView reloadRowsAtIndexPaths:@[_currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  
//    //获取图片
    if (picker.allowsEditing) {
    }
    //返回
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark --- 处理图片便于上传

+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}


#pragma mark --- 上传选中相片
#pragma mark --- 本地保存选中相片

-(void)saveImage:(UIImage*)tempImage WithName:(NSString*)imageName{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}

@end
