//
//  ALPModelProtocol.h
//  Spark
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef uint64_t (^fetchFirstData)(id objData,NSError *error,BOOL hasMore);
typedef void (^fetchNextData)(id objData,NSError *error,BOOL hasMore);

@protocol ALPModelProtocol <NSObject>

@end
