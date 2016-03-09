//
//  NetWork.m
//  Computer
//
//  Created by Trilobita on 16/2/18.
//  Copyright © 2016年  syc. All rights reserved.
//

#import "NetWork.h"
#import "ZJLimitCache.h"

@implementation NetWork

//get方法实现
+ (void)newWorkGetWithURL:(NSString *)url complete:(Complete)complete {
    
    //缓存对象
    ZJLimitCache *cache = [ZJLimitCache shareInstance];
    cache.myTime = 20;
    
    NSData *cacheData = [cache getDataWithNameString:url];
    
    if (cacheData) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        
        complete(nil, responseObject, nil);
    } else {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [cache saveWithData:data andNameString:url];
            
            complete(operation, responseObject, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            complete(operation, nil, error);
        }];
    }
}

//post方法实现
+ (void)newWorkPostWithURL:(NSString *)url andParameter:(NSDictionary *)parameter contentType:(NSString *)type toCache:(BOOL)toCache complete:(Complete)complete {
    
    NSString *urlString = [NSString stringWithFormat:@"%@_topic_id%@_media_id%@", url, parameter[@"topic_id"], parameter[@"media_id"]];
    
    //缓存对象
    ZJLimitCache *cache = [ZJLimitCache shareInstance];
    cache.myTime = 20;
    
    NSData *cacheData = [cache getDataWithNameString:urlString];
    
    if (cacheData && toCache) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        
        complete(nil, responseObject, nil);
    } else {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        if (type) {
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
        }
        
        NSURLSessionDataTask *task = [manager POST:url parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [cache saveWithData:data andNameString:urlString];
            
            complete(nil, responseObject, nil);

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            complete(nil, nil, error);
        }];
        
        [task resume];
    }
    
}

//控制导航条指示器的显示方法实现
+ (void)setIndicate:(BOOL)isStart {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:isStart];
}


@end
