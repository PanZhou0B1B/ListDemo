//
//  ALPTagDelegate.h
//  Spark
//
//  Created by pan on 16/5/10.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ALPDelegateDefine.h"
#import "ALPCollectionViewTagsFlowLayout.h"

@interface ALPTagDelegate : NSObject<ALPCollectionViewTagsDelegateLayout>

@property (nonatomic,copy)CellWillDisplay cellWillDisplayBlock;
@property (nonatomic,copy)ReuseViewWillDisplay reuseViewWillDisplay;
@property (nonatomic,copy)RetModelHeaderBlock retModelHeaderBlock;
@property (nonatomic,copy)RetModelFooterBlock retModelFooterBlock;

- (instancetype)initWithretModelBlock:(RetModelBlock)retBlock selectedBlock:(CellDidSelected)block;

@end
