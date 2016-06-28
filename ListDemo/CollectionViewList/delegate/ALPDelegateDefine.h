//
//  ALPDelegateDefine.h
//  Spark
//
//  Created by pan on 16/5/10.
//  Copyright © 2016年 ali. All rights reserved.
//

#ifndef ALPDelegateDefine_h
#define ALPDelegateDefine_h

#import "ALPCellProtocol.h"
#import "ALPModelProtocol.h"
#import "ALPReuseViewProtocol.h"

typedef void (^CellDidSelected)(id<ALPCellProtocol>cell, NSIndexPath * indexPath);
typedef void (^CellWillDisplay)(id<ALPCellProtocol>cell, NSIndexPath * indexPath);

typedef void (^ReuseViewWillDisplay)(id<ALPReuseViewProtocol>reuseView, NSIndexPath * indexPath,NSString *kind);

typedef CGSize (^RetModelBlock)(UICollectionView *collectionView, NSIndexPath * indexPath);

typedef CGSize (^RetModelHeaderBlock)(UICollectionView *collectionView, NSInteger section);
typedef CGSize (^RetModelFooterBlock)(UICollectionView *collectionView, NSInteger section);

typedef void (^ScrollDragBlock)(CGPoint velocity);

#endif /* ALPDelegateDefine_h */
