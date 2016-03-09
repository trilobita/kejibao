//
//  ViewController.h
//  kejibao
//
//  Created by Trilobita on 16/2/22.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUITabPagerViewController.h"
#import "SubscribeModel.h"

@interface ViewController : GUITabPagerViewController

@property (nonatomic, strong) void(^showMenu)();

@end

