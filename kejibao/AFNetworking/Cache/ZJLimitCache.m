//
//  ZJLimitCache.m
//  kejibao
//
//  Created by Trilobita on 16/3/3.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "ZJLimitCache.h"
#import "NSString+Hashing.h"

static ZJLimitCache *cache = nil;

@implementation ZJLimitCache

+(ZJLimitCache *)shareInstance
{
    @synchronized(self){ //给这个类上锁
        if (cache == nil) {
            cache = [[ZJLimitCache alloc]init];
        }
    }
    return cache;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (cache == nil) {
            cache = [super allocWithZone:zone];
        }
    }
    return cache;
}

-(id)init{
    if (self = [super init]) {
        _myTime=10;
    }
    return self;
}

//存数据 根据接口不同,保存文件,保存 NSData
-(void)saveWithData:(NSData *)data andNameString:(NSString *)urlString
{
    //设置缓存路径
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Cache/",NSHomeDirectory()];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //根据路径创建文件
    //yes代表立刻创建
    [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    if (isSuc) {
//        NSLog(@"创建成功");
//    }else{
//        NSLog(@"创建失败");
//    }
    
    //根据接口 来加密,保存文件,区分文件
    //MD5:不可逆的
    //使用 md5进行加密,可以得到一个16进制的字符串,位数是32位.
    //作用:将原文进行加密,得到固定字符串
    
    //更新成 MD5的字符串
    urlString = [urlString MD5Hash];
    
    //得到每个界面的缓存文件路径,根据接口
    NSString *filePath = [NSString stringWithFormat:@"%@%@",path,urlString];
    
    //立刻将缓存数据写入硬盘
    [data writeToFile:filePath atomically:YES];
    
//    if (isWrite) {
//        NSLog(@"写入缓存成功");
//    }else{
//        NSLog(@"写入缓存失败");
//    }
}

//读取缓存
-(NSData *)getDataWithNameString:(NSString *)urlString
{
    //根据接口取路径
    //获取到 MD5字符串
    urlString = [urlString MD5Hash];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Cache/%@",NSHomeDirectory(),urlString];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断路径下文件是否存在
    if (![manager fileExistsAtPath:path]) {
        return nil;
    }
    
    //比较缓存最后写入时间 和当前时间的差值
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[self getLastWriteFileDate:path]];
    
    if (timeInterval > _myTime) {
        return nil;
    }
    
    //如果符合要求 就读取路径下面的缓存文件
    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSLog(@"%@", data);
    return data;
}

//获取缓存文件的最后写入时间
-(NSDate *)getLastWriteFileDate:(NSString *)path
{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //获取指定路径下面文件的 各种属性
    NSDictionary *dic =  [manager attributesOfItemAtPath:path error:nil];
    
    
//    NSLog(@"dic---%@",dic);
    return dic[NSFileModificationDate];
}

@end
