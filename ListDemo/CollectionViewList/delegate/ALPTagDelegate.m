//
//  ALPTagDelegate.m
//  Spark
//
//  Created by pan on 16/5/10.
//  Copyright © 2016年 ali. All rights reserved.
//

#import "ALPTagDelegate.h"

@interface ALPTagDelegate ()

@property (nonatomic,copy)CellDidSelected selectedBlock;
@property (nonatomic,copy)RetModelBlock retModelBlock;

@end
@implementation ALPTagDelegate

#pragma mark ======  init  ======
- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}
- (instancetype)initWithretModelBlock:(RetModelBlock)retBlock selectedBlock:(CellDidSelected)block
{
    self = [self init];
    
    if(self)
    {
        self.retModelBlock = retBlock;
        self.selectedBlock = block;
        
    }
    return self;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    id<ALPCellProtocol>cell = (id<ALPCellProtocol>)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(_selectedBlock)
    {
        _selectedBlock(cell,indexPath);
    }
}



- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_cellWillDisplayBlock)
    {
        _cellWillDisplayBlock((id<ALPCellProtocol>)cell,indexPath);
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if(_reuseViewWillDisplay)
    {
        _reuseViewWillDisplay((id<ALPReuseViewProtocol>)view,indexPath,elementKind);
    }
}
#pragma mark ======  alptagdelete  ======
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if(_retModelBlock)
    {
        size = _retModelBlock(collectionView,indexPath);
    }
    
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    if(_retModelHeaderBlock)
    {
        size = _retModelHeaderBlock(collectionView,section);
    }
    
    return size;

}
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    if(_retModelFooterBlock)
    {
        size = _retModelFooterBlock(collectionView,section);
    }
    
    return size;
}
@end
