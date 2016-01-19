//
//  CustomTableViewCell.h
//  notice1
//
//  Created by mac on 16/1/7.
//  Copyright © 2016年 张向阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *CustomName;
@property (weak, nonatomic) IBOutlet UILabel *CustomSex;
@property (weak, nonatomic) IBOutlet UILabel *Customskills;
@property (weak, nonatomic) IBOutlet UILabel *CustomPrice;
@property (weak, nonatomic) IBOutlet UILabel *CustomRegister;
@property (weak, nonatomic) IBOutlet UIImageView *CustomPhoto;
@property (weak, nonatomic) IBOutlet UILabel *CustomDistance;

@end
