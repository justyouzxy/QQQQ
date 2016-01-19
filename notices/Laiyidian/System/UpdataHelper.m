//
//  UpdataHelper.m
//  NSB_APP
//
//  Created by zhangwen on 16/1/12.
//  Copyright © 2016年 tz. All rights reserved.
//

#import "UpdataHelper.h"

@interface UpdataHelper () <UIAlertViewDelegate>

@end


@implementation UpdataHelper 

static UpdataHelper* updata = nil;
+(instancetype)client
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        updata = [[UpdataHelper alloc] init];
        //安全性
        updata.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //请求为json
        updata.requestSerializer = [AFJSONRequestSerializer serializer];
        //返回为json
        updata.responseSerializer = [AFJSONResponseSerializer serializer];
        //超时操作
        updata.requestSerializer.timeoutInterval = 5.0f;
        //json接受处理
        [updata.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [updata.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    });
    return updata;
}

-(void)getAppNewVersion:(NSString *)version
{
//    NSString* requestURL = BaseURL;
//    
//    NSDictionary* paraDic = @{@"version":version};
//    
//    [[UpdataHelper client] GET:requestURL parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
//        nil;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if (responseObject) {
//        
//                    NSLog(@"%@",responseObject);
//        
//                    if([[responseObject objectForKey:@"isGoUp"] isEqualToString:@"1"]) {
//                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"版本过期" message:@"农商宝App功能升级，请立即升级！" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"立即升级", nil];
//                        [alertView show];
//                    }
//                }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"BaseURL请求失败");
//    }];
//     
//    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        exit(0);
    } else if (buttonIndex == 1) {
        [self getAppStoreInfo];
    }
}

-(void) getAppStoreInfo {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication* application = [UIApplication sharedApplication];
//            [application openURL:[NSURL URLWithString:AppDownloadURL]];
        });
    });
}

@end
