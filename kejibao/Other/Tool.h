//
//  Tool.h
//  kejibao
//
//  Created by Trilobita on 16/2/24.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "Collection+CoreDataProperties.h"

@interface Tool : NSObject

//修改图片比例
+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+(NewsModel *)collectionToNewsModelWith:(Collection *)collection;
+(Collection *)newsModelToCollectionWith:(NewsModel *)newsModel;
@end
