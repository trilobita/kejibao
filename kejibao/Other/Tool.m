//
//  Tool.m
//  kejibao
//
//  Created by Trilobita on 16/2/24.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "Tool.h"

@implementation Tool


#pragma mark <!--------修改图片比例--------!>
+(UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+(NewsModel *)collectionToNewsModelWith:(Collection *)collection {
    NewsModel *temp = [[NewsModel alloc] init];
    temp = [[NewsModel alloc] init];
    temp.title            = collection.title;
    temp.news_id          = collection.news_id;
    temp.news_description = collection.news_description;
    temp.media_name       = collection.media_name;
    temp.update_time      = collection.update_time;
    temp.clicks           = collection.clicks;
    temp.moburl           = collection.moburl;
    temp.weburl           = collection.weburl;
    return  temp;
}
+(Collection *)newsModelToCollectionWith:(NewsModel *)newsModel {
    
    Collection *temp = [[Collection alloc] init];
    
    temp.title            = newsModel.title;
    temp.moburl           = newsModel.moburl;
    temp.weburl           = newsModel.weburl;
    temp.clicks           = newsModel.clicks;
    temp.news_id          = newsModel.news_id;
    temp.media_name       = newsModel.media_name;
    temp.update_time      = newsModel.update_time;
    temp.news_description = newsModel.news_description;
    
    return temp;
}
@end
