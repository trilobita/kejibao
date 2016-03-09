//
//  NetWork.h
//  Computer
//
//  Created by Trilobita on 16/2/18.
//  Copyright © 2016年  syc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"

/**
 *  下载网络数据完成是回调
 *
 *  @param operation   请求操作
 *  @param responeObjc 回调结果
 *  @param error       报错结果
 */
typedef void(^Complete)(AFHTTPRequestOperation *operation, id responeObjc, NSError *error);

/**
 *  网络请求相关类
 */
@interface NetWork : NSObject

/**
 *  Get方式发起网络请求
 *
 *  @param url 请求路径
 *  @param complete 网络数据下载回调
 */
+ (void)newWorkGetWithURL:(NSString *) url complete:(Complete) complete;

/**
 *  Post方式发起网络请求
 *
 *  @param url       请求路径
 *  @param parameter 请求传入参数
 *  @param complete 网络数据下载回调
 */
+ (void)newWorkPostWithURL:(NSString *) url andParameter:(NSDictionary *) parameter contentType:(NSString *)type toCache:(BOOL)toCache complete:(Complete) complete;
//+ (void)newWorkPostWithURL:(NSString *) url andParameter:(NSDictionary *) parameter complete:(Complete) complete contentType:(NSString *)type;

/**
 *  控制导航条指示器的显示
 *
 *  @param isStart YES显示，NO关闭显示
 */
+ (void)setIndicate:(BOOL)isStart;


@end
