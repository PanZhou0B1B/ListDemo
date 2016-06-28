//
//  ALPBaseDataSource.h
//  Spark
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ALPCellProtocol.h"
#import "ALPModelProtocol.h"

typedef id<ALPCellProtocol> (^RetCellWithConfigureBlock)(UICollectionView *collectionView,id<ALPModelProtocol> model, NSIndexPath * indexPath);
typedef UICollectionReusableView* (^SuppReuseViewBlock)(NSString *kind, UICollectionView *table, NSIndexPath * indexPath);

typedef NSInteger (^RetNumBlock)(NSInteger section);

@interface ALPBaseDataSource : NSObject<UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,copy)RetCellWithConfigureBlock cellBlock;
@property (nonatomic,copy)SuppReuseViewBlock reuserViewBlock;
@property (nonatomic,copy)RetNumBlock retNumBlock;


- (void)refreshCollectionView:(UICollectionView *)table withModels:(NSArray *)models;

- (void)refreshCollectionView:(UICollectionView *)table withFirstPage:(NSArray *)models;
- (void)refreshCollectionView:(UICollectionView *)table withNextPage:(NSArray *)models;
- (void)deleteIndexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table;

//头部插入数据(section=1的情况)
- (void)insertModel:(id)model table:(UICollectionView *)table;
//删除cell
- (void)deleteModelAtIndexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table;
@end
