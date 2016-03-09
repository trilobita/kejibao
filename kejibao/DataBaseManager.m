//
//  OperateDataBase.m
//  kejibao
//
//  Created by Trilobita on 16/3/4.
//  Copyright © 2016年 Trilobita. All rights reserved.
//


#import <CoreData/CoreData.h>

#import "DataBaseManager.h"
#import "Collection+CoreDataProperties.h"

@implementation DataBaseManager
{
    //coreData模型文件 本地数据库文件关联
    NSManagedObjectModel *_managedModel;
    //协调类对象
    NSPersistentStoreCoordinator *_coordinator;
    //上下文对象
    NSManagedObjectContext *_context;
    
    NSString *_path;
}

+ (DataBaseManager *)SingletonPattern {
    static DataBaseManager * singletonManager = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (singletonManager == nil) {
            singletonManager = [[DataBaseManager alloc]init];
            [singletonManager configEnvironment];
        }
        
    });
    
    return singletonManager;
}

- (void)configEnvironment {
    
    _path = [NSString stringWithFormat:@"%@/collection.sqlite",NSHomeDirectory()];
//    NSLog(@"path----->%@", _path);
    
    //实例化模型关联对象
    _managedModel  = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //实例化协调类对象
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedModel];
    
    //协调对象调用，与本地文件添加关系
    [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:_path] options:nil error:nil];
    
    //实例化上下文对象
    _context = [[NSManagedObjectContext alloc] init];
    
    //上下文对象和协调器做连接
    _context.persistentStoreCoordinator = _coordinator;
    
}

//插入数据
- (void)insertObjectWithNewsModel:(NewsModel *)obj {
    
    //实例化数据对象
    Collection *data = [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:_context];
    
    //实体对象写入数据
    data.title            = obj.title;
    data.moburl           = obj.moburl;
    data.weburl           = obj.weburl;
    data.clicks           = obj.clicks;
    data.news_id          = obj.news_id;
    data.media_name       = obj.media_name;
    data.update_time      = obj.update_time;
    data.news_description = obj.news_description;
//    data = [Tool newsModelToCollectionWith:obj];
    
    //写入本地
    [_context save:nil];
    
}
- (void)insertObjectWithCollectionObject:(Collection *)obj {
    
}

//删除数据
- (void)deleteObjectWithNewsModel:(NewsModel *)obj {

    //查找本地对象
    Collection *data = [[self selectObjectWithNewsModel:obj] firstObject];
    
    //删除对象
    [_context deleteObject:data];
    
    //将操作写入本地
    [_context save:nil];
}
- (void)deleteObjectWithCollectionObject:(id)obj {
    //删除对象
    [_context deleteObject:obj];
    //将操作写入本地
    [_context save:nil];
}

//条件查询数据
- (NSArray *)selectObjectWithNewsModel:(NewsModel *)obj {
    //创建检索对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collection"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"news_id=%@",obj.news_id];
    //设置检索条件
    [request setPredicate:predicate];
    
    //执行查找
    NSArray *arr = [_context executeFetchRequest:request error:nil];
    
    return arr;
}

//查询数据
- (NSArray *)selectAllObjectFromDataBase {
    //创建检索对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collection"];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:nil];
    
    //设置检索条件
    [request setPredicate:nil];
    
    //执行查找
    NSArray *arr = [_context executeFetchRequest:request error:nil];
    
    return arr;
}

@end
