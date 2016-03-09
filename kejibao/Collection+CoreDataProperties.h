//
//  Collection+CoreDataProperties.h
//  kejibao
//
//  Created by Trilobita on 16/3/4.
//  Copyright © 2016年 Trilobita. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Collection.h"

NS_ASSUME_NONNULL_BEGIN

@interface Collection (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *news_id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *news_description;
@property (nullable, nonatomic, retain) NSString *update_time;
@property (nullable, nonatomic, retain) NSString *media_name;
@property (nullable, nonatomic, retain) NSString *weburl;
@property (nullable, nonatomic, retain) NSString *clicks;
@property (nullable, nonatomic, retain) NSString *moburl;

@end

NS_ASSUME_NONNULL_END
