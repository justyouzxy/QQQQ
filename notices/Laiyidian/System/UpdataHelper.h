//
//  UpdataHelper.h
//  NSB_APP
//
//  Created by zhangwen on 16/1/12.
//  Copyright © 2016年 tz. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface UpdataHelper : AFHTTPSessionManager

//单例客户端
+(instancetype) client;

//检查跟新
-(void) getAppNewVersion:(NSString*) version;

@end
