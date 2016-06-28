//
//  ALPDelegate.h
//  BasePro
//
//  Created by pan on 16/4/25.
//  Copyright © 2016年 pan. All rights reserved.
//

/**
 本文件是基于UICollectionViewFlowLayout
 **/
#import <Foundation/Foundation.h>

#import "ALPCellProtocol.h"
#import "ALPModelProtocol.h"

#import "ALPDelegateDefine.h"

@interface ALPDelegate : NSObject<UICollectionViewDelegateFlowLayout>

@property (nonatomic,copy)CellWillDisplay cellWillDisplayBlock;
@property (nonatomic,copy)ReuseViewWillDisplay reuseViewWillDisplay;
@property (nonatomic,copy)RetModelHeaderBlock retModelHeaderBlock;

- (instancetype)initWithretModelBlock:(RetModelBlock)retBlock selectedBlock:(CellDidSelected)block;

@end
