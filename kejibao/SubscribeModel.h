//
//  SubscribeModel.h
//  kejibao
//
//  Created by Trilobita on 16/2/26.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *slogan;
@property (nonatomic, strong) NSString *subscribe_id;
@property (nonatomic, strong) NSString *media_id;
@property (nonatomic, strong) NSString *type;


- (void)setSubscribeModelByDictionary:(NSDictionary *)dic;

- (void)testModelPrint;

@end
