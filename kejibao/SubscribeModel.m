//
//  SubscribeModel.m
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SubscribeModel.h"

@implementation SubscribeModel

- (void)setSubscribeModelByDictionary:(NSDictionary *)dic {
    self.title = dic[@"title"];
    self.logo = dic[@"logo"];
    self.slogan = dic[@"slogan"];
    self.subscribe_id = dic[@"subscribe_id"];
    self.media_id = dic[@"media_id"];
    self.type = dic[@"type"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_logo forKey:@"logo"];
    [aCoder encodeObject:_slogan forKey:@"slogan"];
    [aCoder encodeObject:_subscribe_id forKey:@"subscribeId"];
    [aCoder encodeObject:_media_id forKey:@"mediaId"];
    [aCoder encodeObject:_type forKey:@"type"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        self.slogan = [aDecoder decodeObjectForKey:@"slogan"];
        self.subscribe_id = [aDecoder decodeObjectForKey:@"subscribeId"];
        self.media_id = [aDecoder decodeObjectForKey:@"mediaId"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}

- (void)testModelPrint {
    NSLog(@"{\n\ttitle:%@\n\tlogo:%@\n\tslogan:%@\n\tsubscribe_id:%@\n\ttype:%@\n\tmediaId:%@\n}", self.title, self.logo, self.slogan, self.subscribe_id, self.type, self.media_id);

}

@end
