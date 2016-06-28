//
//  WaterModel+Request.m
//  ListDemo
//
//  Created by pan on 16/6/27.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "WaterModel+Request.h"

static uint size = 30;
static uint64_t offset = 0;
static NSString *url = @"";

@implementation WaterModel (Request)

+ (void)requestFirstPageFinishedBlock:(fetchFirstData)block
{
    offset = 0;
    
    NSDictionary *paramsDic = @{
                                @"pageSize":@(size),
                                @"offsetId":@(offset)
                                };
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSMutableArray *models = [[NSMutableArray alloc] init];
        
        for(int i=0;i<30;i++)
        {
            @autoreleasepool {
                WaterModel *model = [WaterModel new];
                
                model.des = [NSString stringWithFormat:@"item %2d",i];
                
                [models addObject:model];
            }
        }
        BOOL hasMore = YES;
        
        offset = models.count;
        block(models,nil,hasMore);
    });
}
+ (void)requestNextPageFinishedBlock:(fetchNextData)block
{
    NSDictionary *paramsDic = @{
                                @"pageSize":@(size),
                                @"offsetId":@(offset)
                                };
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSMutableArray *models = [[NSMutableArray alloc] init];
        
        for(int i=offset;i<30+offset;i++)
        {
            @autoreleasepool {
                WaterModel *model = [WaterModel new];
                
                model.des = [NSString stringWithFormat:@"item %2d",i];
                
                [models addObject:model];
            }
        }
        BOOL hasMore = YES;
        
        offset += models.count;
        block(models,nil,hasMore);
    });
}


@end
