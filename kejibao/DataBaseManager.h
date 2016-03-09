//
//  OperateDataBase.h
//  kejibao
//
//  Created by Trilobita on 16/3/4.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Collection+CoreDataProperties.h"
#import "NewsModel.h"

@interface DataBaseManager : NSObject

+ (DataBaseManager *)SingletonPattern;

- (void)insertObjectWithNewsModel:(NewsModel *)obj;
- (void)insertObjectWithCollectionObject:(Collection *)obj;

- (void)deleteObjectWithNewsModel:(NewsModel *)obj;
- (void)deleteObjectWithCollectionObject:(Collection *)obj;

- (NSArray *)selectObjectWithNewsModel:(NewsModel *)obj;
- (NSArray *)selectAllObjectFromDataBase;

@end
