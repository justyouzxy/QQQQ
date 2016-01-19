//
//  SubjectManageViewController.h
//  Test
//
//  Created by caozhenwei on 16/1/2.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostSelectArray <NSObject>

-(void)getSelectArray:(NSArray *)SelectArray;

@end


@interface SubjectManageViewController : UIViewController
+ (id)initWithSelectedSubjectAndParentController:(NSArray *)subjectArr parentController:(UIViewController *)parentController;

@property (nonatomic,assign)id<PostSelectArray>delegate;

@end
