//
//  ALPBaseDataSource.m
//  Spark
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 ali. All rights reserved.
//

#import "ALPBaseDataSource.h"

@interface ALPBaseDataSource ()

@end
@implementation ALPBaseDataSource

#pragma mark ======  init  ======
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)refreshCollectionView:(UICollectionView *)table withModels:(NSArray *)models
{
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:models];
    
    [table reloadData];


}
- (void)refreshCollectionView:(UICollectionView *)table withFirstPage:(NSArray *)models
{
    //[APCommonUtils mainTread:^{
        [self.dataArray removeAllObjects];
        
        [self.dataArray addObjectsFromArray:models];
        
        [table reloadData];

    //}];
}
- (void)refreshCollectionView:(UICollectionView *)table withNextPage:(NSArray *)models
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger count = models.count+self.dataArray.count;
        
        NSMutableArray *indexPaths = nil;
        indexPaths = [[NSMutableArray alloc] init];
        
        for(NSInteger i=self.dataArray.count; i<count;i++)
        {
            @autoreleasepool {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                [indexPaths addObject:indexPath];
            }
        }
        [self.dataArray addObjectsFromArray:models];
        
        [table performBatchUpdates:^{
            {
                [table insertItemsAtIndexPaths:indexPaths];
            }
            
        } completion:^(BOOL finished) {
            
        }];
    });
}
//头部插入数据(section=1的情况)
- (void)insertModel:(id)model table:(UICollectionView *)table
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(self.dataArray.count>0)
        {
            [table scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        }
        
        [self.dataArray insertObject:model atIndex:0];
        NSArray *indexPaths = @[[NSIndexPath indexPathForItem:0 inSection:0]];
        
        [table performBatchUpdates:^{
            {
                [table insertItemsAtIndexPaths:indexPaths];
            }
            
        } completion:^(BOOL finished) {
            //if(finished)
            {
                [table scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
            }
            
        }];
    });
}
//删除cell
- (void)deleteModelAtIndexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.dataArray removeObjectAtIndex:indexPath.item];
        
        [table performBatchUpdates:^{
            {
                [table deleteItemsAtIndexPaths:@[indexPath]];
            }
            
        } completion:^(BOOL finished) {
            //if(finished)
            {
            }
            
        }];
    });
}
//特别应用在发布图片上
- (void)deleteIndexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    id model = self.dataArray[indexPath.item];
    
    dispatch_async(dispatch_get_main_queue(), ^{

        [self.dataArray removeObject:model];
        
        [table performBatchUpdates:^{
            {
                [table deleteItemsAtIndexPaths:@[indexPath]];
            }
            
        } completion:^(BOOL finished) {
            if(self.dataArray.count == 2)
            {
                [table reloadData];
            }
        }];
    });
}
#pragma mark ======  delegate  ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_retNumBlock)
    {
        return self.retNumBlock(section);
    }
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<ALPModelProtocol> model = [self modelAtIndexPath:indexPath];
    
    id<ALPCellProtocol> cell = nil;//[collectionView dequeueReusableCellWithReuseIdentifier:_reuse forIndexPath:indexPath];
    if(_cellBlock)
    {
        cell = _cellBlock(collectionView,model,indexPath);
    }
    
    return (UICollectionViewCell *)cell;
}

#pragma mark ======  private  ======
- (id<ALPModelProtocol>)modelAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataArray.count<=indexPath.item)
    {
        return nil;
    }
    id<ALPModelProtocol> model = self.dataArray[indexPath.item];
    return model;
}

@end
