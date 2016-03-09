//
//  NewsModel.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString       *news_id;
@property (nonatomic, strong) NSString       *title;
@property (nonatomic, strong) NSString       *news_description;
@property (nonatomic, strong) NSString       *media_name;
@property (nonatomic, strong) NSString       *image_num;
@property (nonatomic, strong) NSString       *update_time;
@property (nonatomic, strong) NSString       *weburl;
@property (nonatomic, strong) NSString       *moburl;
@property (nonatomic, strong) NSString       *clicks;
@property (nonatomic, strong) NSMutableArray *main_image;
@property (nonatomic, assign) BOOL           isColletion;


- (void)setNewsModelByDictionary:(NSDictionary *)dic;

- (void)testToPrintModel;

@end
