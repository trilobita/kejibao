//
//  AllSubscribe.m
//  kejibao
//
//  Created by Trilobita on 16/2/27.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "SubscribeManger.h"
#import "SubscribeModel.h"

@implementation SubscribeManger

+ (SubscribeManger *)defineSubscribeManger {
    static SubscribeManger *manger = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (manger == nil) {
            manger = [[SubscribeManger alloc]init];
            manger.selectedSubscribeArray = [NSMutableArray array];
            manger.mediaSubscribeArray = [NSMutableArray array];
            manger.topicSubscribeArray = [NSMutableArray array];
            manger.index = 0;
        }
        
    });
    
    return manger;
}

- (void)setTopicSubscribeArrayByArray:(NSMutableArray *)array {
    [self addObjects:array toArray:_topicSubscribeArray];
}

- (void)setMediaSubscribeArrayByArray:(NSMutableArray *)array {
    [self addObjects:array toArray:_mediaSubscribeArray];
}

- (void)addObjects:(NSMutableArray *)objs toArray:(NSMutableArray *)array {
    for (SubscribeModel *model in objs) {
        BOOL sign = YES;
        for (SubscribeModel *temp in self.selectedSubscribeArray) {
            if ([temp.title isEqualToString:model.title]) {
                sign = NO;
                break;
            }
        }
        for (SubscribeModel *temp in array) {
            if ([temp.title isEqualToString:model.title]) {
                sign = NO;
                break;
            }
        }
        if (sign) {
            [array addObject:model];
        }
    }
}

@end
