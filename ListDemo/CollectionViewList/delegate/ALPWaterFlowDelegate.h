//
//  ALPWaterFlowDelegate.h
//  Spark
//
//  Created by pan on 16/6/1.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ALPDelegateDefine.h"
#import "ALPCollectionViewWaterLayout.h"
@interface ALPWaterFlowDelegate : NSObject<ALPCollectionViewWaterDelegateLayout>

@property (nonatomic,copy)CellWillDisplay cellWillDisplayBlock;
@property (nonatomic,copy)ReuseViewWillDisplay reuseViewWillDisplay;
@property (nonatomic,copy)RetModelHeaderBlock retModelHeaderBlock;
@property (nonatomic,copy)RetModelFooterBlock retModelFooterBlock;

@property (nonatomic,copy)ScrollDragBlock beginDragBlock;
@property (nonatomic,copy)ScrollDragBlock willEndDragBlock;

- (instancetype)initWithretModelBlock:(RetModelBlock)retBlock selectedBlock:(CellDidSelected)block;

@end
