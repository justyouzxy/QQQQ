//
//  NetRequestURL.h
//  AFNetWork
//
//  Created by qianfeng007 on 15/9/22.
//  Copyright (c) 2015年 ZXY. All rights reserved.
//

#ifndef AFNetWork_NetRequestURL_h
#define AFNetWork_NetRequestURL_h
#define BaseURL @"http://10.0.8.8/sns"

/**************
 注册：GET/POST
 /my/register.php
 
 参数        类型         说明
 username  string		用户名
 password  string		 密码
 email     string		 邮箱
 **************/
#define RegisterUrl @"my/register.php"

/**************
 登录：GET/POST
 /my/login.php
 
 参数          类型         说明
 username    string       用户名
 password    string		  密码
 **************/
#define LoginUrl @"my/login.php"

#define UploadImageUrl @"my/upload_headimage.php"


#endif
