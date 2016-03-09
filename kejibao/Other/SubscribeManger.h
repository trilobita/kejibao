//
//  AllSubscribe.h
//  kejibao
//
//  Created by Trilobita on 16/2/27.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeManger : NSObject

@property (nonatomic, strong) NSMutableArray *selectedSubscribeArray;
@property (nonatomic, strong) NSMutableArray *mediaSubscribeArray;
@property (nonatomic, strong) NSMutableArray *topicSubscribeArray;
@property (nonatomic, assign) NSInteger index;


+ (SubscribeManger *)defineSubscribeManger;

- (void)setMediaSubscribeArrayByArray:(NSMutableArray *)array;
- (void)setTopicSubscribeArrayByArray:(NSMutableArray *)array;

@end
