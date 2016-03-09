//
//  ZJLimitCache.h
//  kejibao
//
//  Created by Trilobita on 16/3/3.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJLimitCache : NSObject

@property (nonatomic, assign) NSTimeInterval myTime;//设置缓存的有效时间

//创建单利
+(ZJLimitCache *)shareInstance;
//存缓存
-(void)saveWithData:(NSData *)data andNameString:(NSString *)urlString;
//读取缓存
-(NSData *)getDataWithNameString:(NSString *)urlString;


@end
