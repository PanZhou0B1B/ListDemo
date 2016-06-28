//
//  WaterModel+Request.h
//  ListDemo
//
//  Created by pan on 16/6/27.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "WaterModel.h"

@interface WaterModel (Request)
+ (void)requestFirstPageFinishedBlock:(fetchFirstData)block;
+ (void)requestNextPageFinishedBlock:(fetchNextData)block;
@end
