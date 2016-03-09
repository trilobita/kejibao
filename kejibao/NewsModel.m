//
//  NewsModel.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
/*
 @property (nonatomic, strong) NSString *news_id;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *news_description;
 @property (nonatomic, strong) NSString *media_name;
 @property (nonatomic, strong) NSString *image_num;
 @property (nonatomic, strong) NSString *update_time;
 @property (nonatomic, strong) NSString *weburl;
 @property (nonatomic, strong) NSString *clicks;
 @property (nonatomic, strong) NSMutableArray *main_image;
 */
-(void)setNewsModelByDictionary:(NSDictionary *)dic {
    
    self.news_id = dic[@"news_id"];
    self.news_description = dic[@"description"];
    self.title = dic[@"title"];
    self.media_name = dic[@"media_name"];
    self.image_num = dic[@"image_num"];
    self.update_time = dic[@"update_time"];
    self.weburl = dic[@"weburl"];
    self.moburl = dic[@"moburl"];
    self.clicks = dic[@"clicks"];
    
    self.main_image = [NSMutableArray array];
    for (NSDictionary *imageDic in dic[@"main_image"]) {
        NSString *temp = imageDic[@"thumb"];
        [self.main_image addObject:temp];
    }
}

-(void)testToPrintModel {
    NSLog(@"{\n\tnews_id:%@\n\ttitle:%@\n\tdescription:%@\n\tmedia_name:%@\n\timage_num:%@\n\tupdate_time:%@\n\tweburl:%@\n\tclicks:%@\n\tmain_image:%@\n}", self.news_id, self.title, self.news_description, self.media_name, self.image_num, self.update_time, self.weburl, self.clicks, self.main_image);

}

@end
